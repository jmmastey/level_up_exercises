DROP DATABASE yadda;
CREATE DATABASE yadda;

\connect yadda

CREATE TABLE breweries (
    id serial PRIMARY KEY,
    name varchar(128) NOT NULL,
    year_founded varchar(4) NOT NULL,
    address varchar(128) NOT NULL,
    city varchar(128) NOT NULL,
    state varchar(2) NOT NULL, -- I can make a lookup for this but I'm lazy
    description text NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL
);

CREATE TABLE beer_styles (
    id serial PRIMARY KEY,
    style varchar(128) NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL,
    UNIQUE(style)
);

CREATE TABLE beers (
    id serial PRIMARY KEY,
    brewery_id integer REFERENCES breweries ON DELETE CASCADE,
    beer_style_id integer REFERENCES beer_styles ON DELETE CASCADE,
    name varchar(64) NOT NULL,
    description text NOT NULL,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
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
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL
);

CREATE TABLE ratings (
    id serial PRIMARY KEY,
    user_id integer REFERENCES users ON DELETE CASCADE,
    beer_id integer REFERENCES beers ON DELETE CASCADE,
    rating  integer NOT NULL,
    comment text default '',
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    created_by varchar(64) NOT NULL,
    updated_by varchar(64) NOT NULL
);

CREATE UNIQUE INDEX breweries_name_and_address ON breweries(name, address);
CREATE UNIQUE INDEX beer_styles_style ON beer_styles(style);
CREATE UNIQUE INDEX beers_breweries_styles_name ON beers(brewery_id, beer_style_id, name);
CREATE UNIQUE INDEX ratings_user_and_beer_id ON ratings(user_id, beer_id);
CREATE UNIQUE INDEX users_email ON users(email);

