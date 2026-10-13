PRAGMA foreign_keys = ON;

CREATE TABLE Restaurant (
    restaurant_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    food_type TEXT NOT NULL CHECK (
        food_type IN (
            'american', 'chinese', 'indian', 'italian',
            'japanese', 'mexican', 'other'
        )
    )
);

CREATE TABLE "User" (
    user_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE Location (
    location_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER NOT NULL,
    latitude REAL NOT NULL CHECK (latitude BETWEEN -90 AND 90),
    longitude REAL NOT NULL CHECK (longitude BETWEEN -180 AND 180),
    city TEXT NOT NULL,
    state_code TEXT,
    country_code TEXT NOT NULL CHECK (length(country_code) = 2),
    address TEXT NOT NULL,

    CONSTRAINT fk_location_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant (restaurant_id)
);

CREATE TABLE Menu (
    menu_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER NOT NULL,
    name TEXT NOT NULL,

    CONSTRAINT fk_menu_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant (restaurant_id)
);

CREATE TABLE Item (
    item_id INTEGER PRIMARY KEY,
    menu_id INTEGER NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    vegan_type TEXT NOT NULL CHECK (
        vegan_type IN ('vegan', 'vegetarian', 'not_vegan')
    ),
    is_spicy INTEGER NOT NULL DEFAULT 0 CHECK (is_spicy IN (0, 1)),
    dollar_price NUMERIC NOT NULL CHECK (dollar_price >= 0),

    CONSTRAINT fk_item_menu
        FOREIGN KEY (menu_id)
        REFERENCES Menu (menu_id)
);

CREATE TABLE Review (
    review_id INTEGER PRIMARY KEY,
    ordered_item_id INTEGER,
    user_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    stars INTEGER NOT NULL CHECK (stars BETWEEN 1 AND 5),
    title TEXT,
    description TEXT,

    CONSTRAINT fk_review_item
        FOREIGN KEY (ordered_item_id)
        REFERENCES Item (item_id),
    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id)
        REFERENCES "User" (user_id),
    CONSTRAINT fk_review_location
        FOREIGN KEY (location_id)
        REFERENCES Location (location_id)
);
