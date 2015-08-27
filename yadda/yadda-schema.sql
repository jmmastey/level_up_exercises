DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;
\connect yadda;
-- Ensures we have a clean starting state for our db.


CREATE TABLE users (
  user_id     SERIAL PRIMARY KEY,
  name        VARCHAR(50)  NOT NULL,
  email       VARCHAR(100) NOT NULL,
  birthday    DATE         NOT NULL,
  password    VARCHAR(50)  NOT NULL,
  modified_on TIMESTAMP DEFAULT current_timestamp,
  modified_by INTEGER REFERENCES users (user_id) ON DELETE SET NULL
);
COMMENT ON TABLE users IS 'Information about each person';
-- Store information on users. name, email, birthday, and password can not be set to null.
-- modified_by can be set to null if the corresponding user is deleted
-- A user has many ratings, and may have many modifications.

CREATE TABLE breweries (
  brewery_id     SERIAL PRIMARY KEY,
  name           VARCHAR(100) NOT NULL,
  street_address VARCHAR(100),
  city           VARCHAR(200) NOT NULL,
  country        VARCHAR(50),
  zip_code       VARCHAR(10),
  description    TEXT,
  founding_year  INTEGER,
  modified_on    TIMESTAMP DEFAULT current_timestamp,
  modified_by    INTEGER REFERENCES users (user_id) ON DELETE SET NULL
);
COMMENT ON TABLE breweries IS 'Information about each brewery';
-- Store brewery information. Name and city must not be null. modified_by
-- may be set to null if the user that modified the brewery has been deleted.
-- Zip is varchar in order to support hyphens. Brewery to beers is one to many.

CREATE TABLE beers (
  beer_id     SERIAL PRIMARY KEY,
  name        VARCHAR(100) NOT NULL,
  style       VARCHAR(100),
  description TEXT,
  brew_year   INTEGER,
  brewery_id  INTEGER NOT NULL REFERENCES breweries ON DELETE CASCADE,
  modified_on TIMESTAMP DEFAULT current_timestamp,
  modified_by INTEGER NOT NULL REFERENCES users (user_id) ON DELETE SET NULL
);
COMMENT ON TABLE beers IS 'Information about each beer';
-- Store beer information. name and style must be under 100 characters.
-- Brewery for a specific beer can not be null, and when a brewery is deleted, all
-- corresponding beers created by that brewery are deleted as well.
-- When modified_by may be set to null if the user that modified the beer is deleted.
-- beer (singular) to brewery is one to one, though a brewery has many beers.

CREATE TABLE ratings (
  rating_id   SERIAL PRIMARY KEY,
  user_id     INTEGER REFERENCES users (user_id) ON DELETE CASCADE,
  beer_id     INTEGER REFERENCES beers (beer_id) ON DELETE CASCADE,
  look        SMALLINT,
  smell       SMALLINT,
  taste       SMALLINT,
  overall     SMALLINT,
  modified_on TIMESTAMP DEFAULT current_timestamp,
  modified_by INTEGER REFERENCES users (user_id) ON DELETE SET NULL,
  CHECK (look > 0 AND look < 11),
  CHECK (smell > 0 AND smell < 11),
  CHECK (taste > 0 AND taste < 11),
  CHECK (overall > 0 AND overall < 11)
);
COMMENT ON TABLE ratings IS 'Ratings for each beer';
-- Store rating information. When a user is deleted, the user's ratings are too.
-- When a beer is deleted, it's ratings are deleted too. Look, smell, taste, and
-- overall are integers between 1 and 10. If a user that has modified a
-- rating has been deleted modified_by will be set to null.
-- A user has many ratings, a beer has many ratings.

