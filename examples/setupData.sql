-- Synthetic sample data for the Albuquerque restaurant finder project.

INSERT INTO Restaurant (restaurant_id, name, food_type) VALUES
(1, 'Mesa Lantern Kitchen', 'american'),
(2, 'Trattoria Sol', 'italian'),
(3, 'Pinyon and Plate', 'american'),
(4, 'Saffron Road Cafe', 'indian'),
(5, 'Green Chile Hearth', 'mexican'),
(6, 'Kumo Garden', 'japanese'),
(7, 'Bosque Brick Oven', 'italian'),
(8, 'High Desert Dumpling House', 'chinese'),
(9, 'Sunflower Bowl Kitchen', 'other'),
(10, 'Nob Hill Morning Table', 'american');

INSERT INTO `User` (user_id, name, email) VALUES
(1, 'Alex Morgan', 'alex.morgan@example.com'),
(2, 'Jamie Rivera', 'jamie.rivera@example.com'),
(3, 'Taylor Chen', 'taylor.chen@example.com'),
(4, 'Riley Patel', 'riley.patel@example.com'),
(5, 'Jordan Brooks', 'jordan.brooks@example.com'),
(6, 'Casey Nguyen', 'casey.nguyen@example.com');

INSERT INTO Location
    (location_id, restaurant_id, latitude, longitude, city, state_code, country_code, address)
VALUES
(1, 1, 35.096400, -106.669200, 'Albuquerque', 'NM', 'US', '1800 Mountain Road NW'),
(2, 2, 35.084800, -106.650100, 'Albuquerque', 'NM', 'US', '412 Central Avenue SE'),
(3, 3, 35.102100, -106.629800, 'Albuquerque', 'NM', 'US', '800 Lomas Boulevard NE'),
(4, 4, 35.078600, -106.590700, 'Albuquerque', 'NM', 'US', '3200 Central Avenue SE'),
(5, 5, 35.110300, -106.647500, 'Albuquerque', 'NM', 'US', '1500 Fourth Street NW'),
(6, 6, 35.077800, -106.613200, 'Albuquerque', 'NM', 'US', '2210 Central Avenue SE'),
(7, 7, 35.125500, -106.594400, 'Albuquerque', 'NM', 'US', '6200 San Mateo Boulevard NE'),
(8, 8, 35.090500, -106.615500, 'Albuquerque', 'NM', 'US', '900 Central Avenue SE'),
(9, 9, 35.065800, -106.606800, 'Albuquerque', 'NM', 'US', '3300 Central Avenue SE'),
(10, 10, 35.078900, -106.610200, 'Albuquerque', 'NM', 'US', '2100 Central Avenue SE');

INSERT INTO Menu (menu_id, restaurant_id, name) VALUES
(1, 1, 'All Day Menu'),
(2, 2, 'Dinner Menu'),
(3, 3, 'Seasonal Menu'),
(4, 4, 'Main Menu'),
(5, 5, 'Lunch Menu'),
(6, 6, 'Dinner Menu'),
(7, 7, 'Pizza and Pasta Menu'),
(8, 8, 'Dumpling House Menu'),
(9, 9, 'Grain Bowl Menu'),
(10, 10, 'Breakfast and Brunch Menu'),
(11, 2, 'Lunch Menu'),
(12, 5, 'Dinner Menu');

INSERT INTO Item
    (item_id, menu_id, name, description, vegan_type, is_spicy, dollar_price)
VALUES
(1, 1, 'Green Chile Veggie Burger', 'House-made bean patty with roasted green chile and lettuce.', 'vegan', 1, 13.50),
(2, 1, 'Roasted Squash Salad', 'Roasted squash, pepitas, greens, and citrus vinaigrette.', 'vegan', 0, 11.00),
(3, 1, 'Green Chile Cheeseburger', 'Beef patty with cheddar and roasted green chile.', 'not_vegan', 1, 15.00),
(4, 2, 'Pasta al Pomodoro', 'Spaghetti with slow-cooked tomato, garlic, and basil.', 'vegan', 0, 17.00),
(5, 2, 'Wild Mushroom Ravioli', 'Mushroom ravioli with parmesan cream sauce.', 'vegetarian', 0, 21.00),
(6, 2, 'Arrabbiata Penne', 'Penne with spicy tomato sauce and fresh parsley.', 'vegan', 1, 18.00),
(7, 3, 'Blue Corn Tofu Bowl', 'Blue corn, grilled tofu, beans, greens, and chile-lime dressing.', 'vegan', 1, 14.00),
(8, 3, 'Pinyon Pancakes', 'Cornmeal pancakes with local honey and butter.', 'vegetarian', 0, 12.00),
(9, 4, 'Chana Masala', 'Chickpeas simmered with tomato, ginger, and warming spices.', 'vegan', 1, 15.00),
(10, 4, 'Vegetable Biryani', 'Basmati rice with seasonal vegetables and spices.', 'vegan', 0, 16.00),
(11, 4, 'Chicken Tikka Masala', 'Chicken in a creamy tomato sauce.', 'not_vegan', 1, 19.00),
(12, 5, 'Black Bean and Green Chile Tacos', 'Three corn tortillas with black beans, green chile, and cabbage.', 'vegan', 1, 12.00),
(13, 5, 'Calabacitas Bowl', 'Squash, corn, pinto beans, and red chile over rice.', 'vegan', 0, 13.00),
(14, 5, 'Carne Adovada Plate', 'Pork simmered in red chile with rice and beans.', 'not_vegan', 1, 18.00),
(15, 6, 'Avocado Cucumber Roll', 'Avocado and cucumber rolled with seasoned rice.', 'vegan', 0, 9.00),
(16, 6, 'Miso Mushroom Ramen', 'Noodles, mushrooms, greens, and miso broth.', 'vegan', 0, 16.00),
(17, 6, 'Spicy Tofu Ramen', 'Tofu and vegetables in a hot sesame broth.', 'vegan', 1, 17.00),
(18, 7, 'Roasted Garlic Marinara Pizza', 'Thin crust with tomato, roasted garlic, and basil.', 'vegan', 0, 16.00),
(19, 7, 'Lemon Ricotta Gnocchi', 'Potato gnocchi with ricotta, lemon, and herbs.', 'vegetarian', 0, 19.00),
(20, 8, 'Vegetable Dumplings', 'Pan-seared dumplings filled with cabbage, tofu, and ginger.', 'vegan', 0, 11.00),
(21, 8, 'Chili Oil Noodles', 'Wheat noodles with vegetables and house chili oil.', 'vegan', 1, 13.00),
(22, 8, 'Pork and Chive Dumplings', 'Pork dumplings served with black vinegar.', 'not_vegan', 0, 12.00),
(23, 9, 'Spicy Tofu Power Bowl', 'Tofu, brown rice, greens, and spicy sesame dressing.', 'vegan', 1, 14.50),
(24, 9, 'Crispy Chickpea Bowl', 'Chickpeas, quinoa, greens, and lemon tahini.', 'vegan', 0, 13.50),
(25, 10, 'Blue Corn Oatcakes', 'Oatcakes with fruit and maple syrup.', 'vegan', 0, 10.00),
(26, 10, 'Green Chile Breakfast Burrito', 'Egg, potato, cheese, and green chile in a flour tortilla.', 'vegetarian', 1, 12.00),
(27, 11, 'Margherita Pizza', 'Tomato, mozzarella, and basil on a thin crust.', 'vegetarian', 0, 15.00),
(28, 11, 'Lentil and Tomato Soup', 'Red lentils, tomato, herbs, and olive oil.', 'vegan', 0, 9.00),
(29, 12, 'Vegan Red Chile Enchiladas', 'Corn tortillas with beans, vegetables, and red chile.', 'vegan', 1, 14.00),
(30, 12, 'Street Corn', 'Roasted corn with lime, chile, and cotija.', 'vegetarian', 1, 6.00);

INSERT INTO Review
    (review_id, ordered_item_id, user_id, location_id, stars, title, description)
VALUES
(1, 1, 1, 1, 5, 'Great green chile', 'The veggie burger was filling and the green chile had a nice kick.'),
(2, 2, 2, 1, 4, 'Fresh lunch', 'The squash salad was fresh and the citrus dressing was bright.'),
(3, 1, 3, 1, 5, 'Best vegan burger', 'A flavorful plant-based option with a generous portion.'),
(4, 3, 4, 1, 4, 'Good local flavors', 'Tasty burger and a relaxed neighborhood atmosphere.'),
(5, 2, 5, 1, 5, 'Excellent salad', 'The roasted squash and pepitas made this a satisfying meal.'),
(6, 4, 1, 2, 5, 'Simple and delicious', 'The tomato sauce tasted fresh and the pasta was cooked well.'),
(7, 5, 2, 2, 5, 'Lovely dinner', 'The mushroom filling was rich and the service was attentive.'),
(8, 6, 3, 2, 4, 'Spicy pasta', 'Good heat and a generous portion; ask for less chili if sensitive.'),
(9, 4, 4, 2, 5, 'Excellent vegan pasta', 'A surprisingly satisfying vegan option with plenty of basil.'),
(10, 27, 5, 2, 5, 'Great lunch pizza', 'A crisp crust and balanced tomato and basil.'),
(11, 7, 1, 3, 4, 'Hearty bowl', 'The tofu bowl was filling and the chile-lime dressing was flavorful.'),
(12, 8, 2, 3, 4, 'Nice brunch', 'The pancakes were good and the portions were generous.'),
(13, 9, 3, 4, 4, 'Comforting curry', 'The chickpeas were tender and the curry had a pleasant level of spice.'),
(14, 10, 4, 4, 5, 'Fragrant rice', 'The vegetable biryani was aromatic and made a great lunch.'),
(15, 11, 5, 4, 4, 'Good curry', 'Rich sauce and tender chicken, with friendly service.'),
(16, 12, 6, 5, 4, 'Tasty tacos', 'The black bean tacos were flavorful and easy to customize.'),
(17, 13, 1, 5, 4, 'Comforting bowl', 'A good mix of squash, corn, and beans.'),
(18, 14, 2, 5, 5, 'Excellent red chile', 'The carne adovada was tender with a deep chile flavor.'),
(19, 29, 3, 5, 3, 'Good but spicy', 'The enchiladas were tasty, though the red chile was hotter than expected.'),
(20, 15, 4, 6, 4, 'Fresh roll', 'The avocado cucumber roll was simple and fresh.'),
(21, 17, 5, 6, 5, 'Great spicy ramen', 'The broth had a strong sesame flavor and a satisfying amount of heat.'),
(22, 18, 6, 7, 5, 'Excellent vegan pizza', 'The crust was crisp and the garlic and basil worked very well together.'),
(23, 19, 1, 7, 4, 'Good gnocchi', 'Soft gnocchi with a bright lemon flavor.'),
(24, 18, 2, 7, 4, 'Solid pizza', 'A nice thin crust and good tomato sauce.'),
(25, 20, 3, 8, 3, 'Good dumplings', 'The vegetable filling was tasty, though the dumplings were a little oily.'),
(26, 21, 4, 8, 4, 'Noodles with a kick', 'The chili oil noodles were spicy and came in a generous portion.'),
(27, 23, 5, 9, 5, 'Favorite lunch bowl', 'The tofu bowl was fresh, filling, and had a balanced spicy dressing.'),
(28, 24, 6, 9, 5, 'Bright and filling', 'The chickpeas and lemon tahini made a great combination.'),
(29, 23, 1, 9, 4, 'Good value', 'A flavorful bowl at a reasonable price.'),
(30, 25, 2, 10, 4, 'Good breakfast', 'The oatcakes were hearty and the fruit was fresh.'),
(31, 26, 3, 10, 5, 'New Mexico classic', 'A filling breakfast burrito with just the right amount of green chile.'),
(32, 28, 4, 2, 5, 'Nice soup', 'The lentil soup was light, flavorful, and a good value.');
