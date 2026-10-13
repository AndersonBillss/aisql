import json
from openai import OpenAI
import os
import sqlite3
from time import time

print("Running db_bot.py!")

fdir = os.path.dirname(__file__)


def getPath(fname):
    return os.path.join(fdir, fname)


# SQLITE
sqliteDbPath = getPath("aidb.sqlite")
setupSqlPath = getPath("setup.sql")
setupSqlDataPath = getPath("setupData.sql")

# Erase previous db
if os.path.exists(sqliteDbPath):
    os.remove(sqliteDbPath)

# create new db
sqliteCon = sqlite3.connect(sqliteDbPath)
sqliteCursor = sqliteCon.cursor()

# read in setup files
with open(setupSqlPath) as setupSqlFile, open(setupSqlDataPath) as setupSqlDataFile:
    setupSqlScript = setupSqlFile.read()
    setupSQlDataScript = setupSqlDataFile.read()

# execute setup files
sqliteCursor.executescript(setupSqlScript)  # setup tables and keys
sqliteCursor.executescript(setupSQlDataScript)  # setup tables and keys


def runSql(query):
    result = sqliteCursor.execute(query).fetchall()
    return result


# OPENAI
configPath = getPath("config.json")
print(configPath)
with open(configPath) as configFile:
    config = json.load(configFile)

openAiClient = OpenAI(api_key=config["openaiKey"])
openAiClient.models.list()  # check if the key is valid (update in config.json)
chosen_model = "gpt-4o"


def getChatGptResponse(content):
    stream = openAiClient.chat.completions.create(
        model=chosen_model,
        messages=[{"role": "user", "content": content}],
        stream=True,
    )

    responseList = []
    for chunk in stream:
        if chunk.choices[0].delta.content is not None:
            responseList.append(chunk.choices[0].delta.content)

    result = "".join(responseList)
    return result


# strategies
commonSqlOnlyRequest = " Give me a sqlite select statement that answers the question. Only respond with sqlite syntax. If there is an error do not explain it!"
strategies = {
    "zero_shot": setupSqlScript + commonSqlOnlyRequest,
    "single_domain_double_shot": (
        setupSqlScript
        + " Example question: Which vegan menu items in Albuquerque cost less than $15? "
        + "Example SQL: SELECT r.name AS restaurant_name, i.name AS item_name, i.dollar_price "
        + "FROM Restaurant r JOIN Location l ON l.restaurant_id = r.restaurant_id "
        + "JOIN Menu m ON m.restaurant_id = r.restaurant_id "
        + "JOIN Item i ON i.menu_id = m.menu_id "
        + "WHERE l.city = 'Albuquerque' AND l.state_code = 'NM' "
        + "AND i.vegan_type = 'vegan' AND i.dollar_price < 15 "
        + "ORDER BY i.dollar_price; "
        + "Second example question: Which Albuquerque restaurants have the most reviews? "
        + "Example SQL: SELECT r.name AS restaurant_name, COUNT(rv.review_id) AS review_count, "
        + "ROUND(AVG(rv.stars), 2) AS average_rating "
        + "FROM Restaurant r JOIN Location l ON l.restaurant_id = r.restaurant_id "
        + "JOIN Review rv ON rv.location_id = l.location_id "
        + "WHERE l.city = 'Albuquerque' AND l.state_code = 'NM' "
        + "GROUP BY r.restaurant_id, r.name "
        + "ORDER BY review_count DESC, average_rating DESC LIMIT 1. "
        + commonSqlOnlyRequest
    ),
    # TODO add strategies as descirbed in the paper (multi-domain)
}

questions = [
    # Approximate home coordinates for Albuquerque, New Mexico.
    "I live in Albuquerque, New Mexico (approximately latitude 35.0844, longitude -106.6504). Which restaurants within about 10 miles have vegan menu items, and what are those items and prices?",
    "Which Italian restaurant in Albuquerque has the highest average review rating? Include its review count and average stars.",
    "Which vegan menu items in Albuquerque have reviews? Show the restaurant, item, average star rating, and number of reviews.",
    "What are the three most reviewed restaurants in Albuquerque, and what is each restaurant's average rating?",
    "Which restaurant's longitude tastes the most like a vegan song, and how many stars does its latitude have?",
    # "I live in Albuquerque, New Mexico (approximately latitude 35.0844, longitude -106.6504). What are some highly rated places nearby with vegan food? Include each restaurant's name, vegan items, prices, and average review rating.",
    # "I live in Albuquerque, New Mexico (approximately latitude 35.0844, longitude -106.6504). Which Italian restaurants are nearby, and which has the highest average review rating?",
    # "What is the highest-rated restaurant in Albuquerque, New Mexico? Show its name, cuisine, average star rating, and number of reviews.",
    # "Which restaurants in Albuquerque have vegan items that cost less than $15? List the restaurant, item, and price.",
    # "Which nearby restaurants have spicy vegan menu items? Include the item name, restaurant name, and price.",
    # "Which restaurants in Albuquerque have an average review rating of at least 4 stars? Sort them from highest to lowest rating.",
    # "What are the five most reviewed restaurants in Albuquerque, New Mexico, and what are their average ratings?",
    # "Which Italian menu items have the highest review ratings in Albuquerque? Include their restaurants and prices.",
    # "Show the restaurants near my Albuquerque location that have both vegan and vegetarian menu options.",
    # "Which restaurants in Albuquerque have the lowest-priced vegan menu item, and what is that item?",
    # "What do reviewers say about the vegan menu items at restaurants near Albuquerque, New Mexico? Include the restaurant, item, review title, and star rating.",
]


# use the markdown for the sql syntax to find the SQL query
def sanitizeForJustSql(value):
    gptStartSqlMarker = "```"
    gptEndSqlMarker = "```"
    if gptStartSqlMarker in value:
        # Split at the first ``` and take everything after it
        value = value.split(gptStartSqlMarker, 1)[1]
        # Find the newline after the language identifier (sql, sqlite, etc.)
        newline_index = value.find("\n")
        if newline_index != -1:
            value = value[newline_index + 1 :]
    if gptEndSqlMarker in value:
        # Split at the closing ``` and take everything before it
        value = value.split(gptEndSqlMarker, 1)[0]

    return value.strip()


for strategy in strategies:
    responses = {"strategy": strategy, "prompt_prefix": strategies[strategy]}
    questionResults = []
    print("########################################################################")
    print(f"Running strategy: {strategy}")
    for question in questions:
        print(
            "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        )
        print("Question:")
        print(question)
        error = "None"
        try:
            getSqlFromQuestionEngineeredPrompt = strategies[strategy] + " " + question
            sqlSyntaxResponse = getChatGptResponse(getSqlFromQuestionEngineeredPrompt)
            sqlSyntaxResponse = sanitizeForJustSql(sqlSyntaxResponse)
            print("SQL Syntax Response:")
            print(sqlSyntaxResponse)
            queryRawResponse = str(runSql(sqlSyntaxResponse))
            print("Query Raw Response:")
            print(queryRawResponse)

            # TODO this prompt is insufficient. ChatGPT doesn't have all the context that it needs.
            # What context would help the friendly response be more successful? Can you fix it?
            friendlyResultsPrompt = (
                'I asked a question "'
                + question
                + '" and the response was "'
                + queryRawResponse
                + '" Please, just give a concise response in a more friendly way? Please do not give any other suggests or chatter.'
            )
            friendlyResponse = getChatGptResponse(friendlyResultsPrompt)
            print("Friendly Response:")
            print(friendlyResponse)
        except Exception as err:
            error = str(err)
            print(err)

        questionResults.append(
            {
                "question": question,
                "sql": sqlSyntaxResponse,
                "queryRawResponse": queryRawResponse,
                "friendlyResponse": friendlyResponse,
                "error": error,
            }
        )

    responses["questionResults"] = questionResults

    with open(getPath(f"response_{strategy}_{time()}.json"), "w") as outFile:
        json.dump(responses, outFile, indent=2)


sqliteCursor.close()
sqliteCon.close()
print("Done!")
