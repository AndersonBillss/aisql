CREATE TABLE Restaurant (
    restaurant_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    food_type ENUM(
        'american', 'chinese', 'indian', 'italian',
        'japanese', 'mexican', 'other'
    ) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE User (
    user_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE Location (
    location_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    restaurant_id BIGINT UNSIGNED NOT NULL,
    latitude DECIMAL(9, 6) NOT NULL,
    longitude DECIMAL(9, 6) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state_code VARCHAR(20),
    country_code CHAR(2) NOT NULL,
    address VARCHAR(255) NOT NULL,

    CONSTRAINT chk_location_latitude
        CHECK (latitude BETWEEN -90 AND 90),
    CONSTRAINT chk_location_longitude
        CHECK (longitude BETWEEN -180 AND 180),

    CONSTRAINT fk_location_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant (restaurant_id)
) ENGINE = InnoDB;

CREATE TABLE Menu (
    menu_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    restaurant_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(150) NOT NULL,

    CONSTRAINT fk_menu_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES Restaurant (restaurant_id)
) ENGINE = InnoDB;

CREATE TABLE Item (
    item_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    menu_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    vegan_type ENUM('vegan', 'vegetarian', 'not_vegan') NOT NULL,
    is_spicy BOOLEAN NOT NULL DEFAULT FALSE,
    dollar_price DECIMAL(8, 2) NOT NULL,

    CONSTRAINT chk_item_price
        CHECK (dollar_price >= 0),

    CONSTRAINT fk_item_menu
        FOREIGN KEY (menu_id)
        REFERENCES Menu (menu_id)
) ENGINE = InnoDB;

CREATE TABLE Review (
    review_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ordered_item_id BIGINT UNSIGNED,
    user_id BIGINT UNSIGNED NOT NULL,
    location_id BIGINT UNSIGNED NOT NULL,
    stars TINYINT UNSIGNED NOT NULL,
    title VARCHAR(200),
    description TEXT,

    CONSTRAINT chk_review_stars
        CHECK (stars BETWEEN 1 AND 5),

    CONSTRAINT fk_review_item
        FOREIGN KEY (ordered_item_id)
        REFERENCES Item (item_id),
    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id)
        REFERENCES User (user_id),
    CONSTRAINT fk_review_location
        FOREIGN KEY (location_id)
        REFERENCES Location (location_id)
) ENGINE = InnoDB;
