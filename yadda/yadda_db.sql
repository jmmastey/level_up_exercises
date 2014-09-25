DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;

\connect yadda

CREATE TABLE breweries (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL,
    year_founded integer NOT NULL,
    address varchar(128) NOT NULL,
    city varchar(128) NOT NULL,
    state char(2) NOT NULL,
    description text NOT NULL,
    created_at timestamptz NOT NULL,
    updated_at timestamptz NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL
);

CREATE TABLE beer_styles (
    id serial PRIMARY KEY,
    style varchar(128) NOT NULL,
    created_at timestamptz NOT NULL,
    updated_at timestamptz NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL
);

CREATE TABLE beers (
    id serial PRIMARY KEY,
    brewery_id integer REFERENCES breweries ON DELETE CASCADE,
    beer_style_id integer REFERENCES beer_styles ON DELETE CASCADE,
    name varchar(64) NOT NULL,
    description text NOT NULL,
    created_at timestamptz NOT NULL,
    updated_at timestamptz NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL
);


CREATE TABLE users (
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    email     varchar (255) NOT NULL,
    birth_date date NOT NULL,
    blood_type varchar(2) NOT NULL,
    created_at timestamptz NOT NULL,
    updated_at timestamptz NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL
);

CREATE TABLE ratings (
    id serial PRIMARY KEY,
    user_id integer REFERENCES users ON DELETE CASCADE,
    beer_id integer REFERENCES beers ON DELETE CASCADE,
    rating  integer NOT NULL,
    comments text default '',
    created_at timestamptz NOT NULL,
    updated_at timestamptz NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL
);

CREATE UNIQUE INDEX breweries_name_and_address ON breweries(name, address);
CREATE UNIQUE INDEX beer_styles_style ON beer_styles(style);
CREATE UNIQUE INDEX beers_breweries_styles_name ON beers(brewery_id, beer_style_id, name);
CREATE UNIQUE INDEX ratings_user_and_beer_id ON ratings(user_id, beer_id);
CREATE UNIQUE INDEX users_email ON users(email);

-- Begin a few insertions

INSERT INTO breweries (
    name,
    year_founded,
    address,
    city,
    state,
    description,
    created_at,
    updated_at,
    created_by,
    updated_by
)
VALUES(
    'Goose Island Brewery',
    1988,
    '1800 W Fulton st',
    'Chicago',
    'IL',
    'Makers of 312 and Matilda',
    now() at time zone 'UTC',
    now() at time zone 'UTC',
    current_user,
    current_user
);

INSERT INTO beer_styles (
    style,
    created_at,
    updated_at,
    created_by,
    updated_by
)
VALUES(
    'American Pale Wheat Ale',
    now() at time zone 'UTC',
    now() at time zone 'UTC',
    current_user,
    current_user
);

INSERT INTO beers(
    brewery_id,
    beer_style_id,
    name,
    description,
    created_at,
    updated_at,
    created_by,
    updated_by
)
VALUES(
    1,
    1,
    '312 Urban Wheat',
    'Hazy staw color, light orange hop aroma',
    now() at time zone 'UTC',
    now() at time zone 'UTC',
    current_user,
    current_user
);

INSERT INTO users (
    first_name,
    last_name,
    email,
    birth_date,
    blood_type,
    created_at,
    updated_at,
    created_by,
    updated_by
)
VALUES(
    'Franco',
    'Reyes',
    'freyes1988@gmail.com',
    '1988-04-15',
    'O-',
    now() at time zone 'UTC',
    now() at time zone 'UTC',
    current_user,
    current_user
);

INSERT INTO ratings (
    user_id,
    beer_id,
    rating,
    comments,
    created_at,
    updated_at,
    created_by,
    updated_by
)
VALUES(
    1,
    1,
    1,
    'This beer is like awesome, man!',
    now() at time zone 'UTC',
    now() at time zone 'UTC',
    current_user,
    current_user
);

-- Like, made an error in my beer rating man
UPDATE ratings
SET rating = 5, updated_at = now() at time zone 'UTC', updated_by = current_user
WHERE user_id = 1 AND beer_id = 1;

INSERT INTO beers(
    brewery_id,
    beer_style_id,
    name,
    description,
    created_at,
    updated_at,
    created_by,
    updated_by
)
VALUES(
    1,
    1,
    '312 Pale Ale',
    'Hazy staw color, light orange hop aroma',
    now() at time zone 'UTC',
    now() at time zone 'UTC',
    current_user,
    current_user
);

INSERT INTO ratings (
    user_id,
    beer_id,
    rating,
    comments,
    created_at,
    updated_at,
    created_by,
    updated_by
)
VALUES(
    1,
    2,
    4,
    'This beer is also awesome, man! But not as awesome as the other beer',
    now() at time zone 'UTC',
    now() at time zone 'UTC',
    current_user,
    current_user
);

-- Was like told not to post ratings on beer. Bummer.
DELETE FROM ratings WHERE user_id = 1 AND beer_id = 2;
