DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;
\connect yadda;
-- Ensures we have a clean starting state for our db.


CREATE TABLE users (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(50)  NOT NULL,
  email       VARCHAR(100) NOT NULL,
  birthday    DATE         NOT NULL,
  password    VARCHAR(50)  NOT NULL,
  modified_on TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
  modified_by VARCHAR(50)
);
COMMENT ON TABLE users IS 'Information about each person';
-- Store information on users. name, email, birthday, and password can not be set to null.
-- A user has many ratings, and may have many modifications.

CREATE TABLE breweries (
  id             SERIAL PRIMARY KEY,
  name           VARCHAR(100) NOT NULL,
  street_address VARCHAR(100),
  city           VARCHAR(200) NOT NULL,
  country        VARCHAR(50) NOT NULL,
  zip_code       VARCHAR(10),
  description    TEXT NOT NULL,
  founding_year  INTEGER,
  modified_on    TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
  modified_by    VARCHAR(50),
  created_on     TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
  created_by     VARCHAR(50)
);
COMMENT ON TABLE breweries IS 'Information about each brewery';
-- Store brewery information. Name and city must not be null.
-- Zip is varchar in order to support hyphens. Brewery to beers is one to many.


CREATE TABLE styles (
  id          SERIAL PRIMARY KEY,
  style       VARCHAR(50) NOT NULL
);
-- Store a table of styles to be referenced by the beers table to normalize db.

CREATE TABLE beers (
  id          SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  style_id    INTEGER NOT NULL REFERENCES styles (id) ON DELETE SET NULL,
  description TEXT,
  brew_year   INTEGER,
  brewery_id  INTEGER NOT NULL REFERENCES breweries ON DELETE CASCADE,
  modified_on TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
  modified_by VARCHAR(50),
  created_on  TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
  created_by  VARCHAR(50)
);
COMMENT ON TABLE beers IS 'Information about each beer';
-- Store beer information. name and style must be under 100 characters.
-- Brewery for a specific beer can not be null, and when a brewery is deleted, all
-- corresponding beers created by that brewery are deleted as well.
-- beer (singular) to brewery is one to one, though a brewery has many beers.

CREATE TABLE ratings (
  id          SERIAL PRIMARY KEY,
  user_id     INTEGER REFERENCES users (id) ON DELETE CASCADE,
  beer_id     INTEGER REFERENCES beers (id) ON DELETE CASCADE,
  look        SMALLINT CHECK (look > 0 AND look < 11),
  smell       SMALLINT CHECK (smell > 0 AND smell < 11),
  taste       SMALLINT CHECK (taste > 0 AND taste < 11),
  overall     SMALLINT CHECK (overall > 0 AND overall < 11),
  modified_on TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
  modified_by VARCHAR(50),
  created_on  TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
  created_by  VARCHAR(50)
);
COMMENT ON TABLE ratings IS 'Ratings for each beer';
-- Store rating information. When a user is deleted, the user's ratings are too.
-- When a beer is deleted, it's ratings are deleted too. Look, smell, taste, and
-- overall are integers between 1 and 10.
-- A user has many ratings, a beer has many ratings.

CREATE INDEX beers_brewery_id on beers(brewery_id);
CREATE INDEX beer_style_id on beers(style_id);
CREATE INDEX ratings_beer_id on ratings(beer_id);
CREATE INDEX ratings_id_index ON ratings(id);
CREATE INDEX ratings_user_id_index ON ratings(user_id);
CREATE INDEX ratings_beer_id_index ON ratings(beer_id);
CREATE INDEX ratings_overall_index ON ratings(overall);
