DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;

\CONNECT yadda;

CREATE TABLE breweries (
  brewery_id     SERIAL PRIMARY KEY,
  name           VARCHAR(100) NOT NULL,
  street_address VARCHAR(100),
  city           VARCHAR(200) NOT NULL,
  country        VARCHAR(50),
  description    TEXT,
  founding_year  INTEGER,
  modified_on    TIMESTAMP DEFAULT current_timestamp,
  modified_by    INTEGER      NOT NULL REFERENCES users (user_id) ON DELETE SET NULL
);
COMMENT ON TABLE breweries IS 'Information about each brewery';

CREATE TABLE beers (
  beer_id     SERIAL PRIMARY KEY,
  name        VARCHAR(100),
  style       VARCHAR(100),
  description TEXT,
  brew_year   INTEGER,
  brewery_id  INTEGER NOT NULL REFERENCES breweries ON DELETE CASCADE,
  modified_on TIMESTAMP DEFAULT current_timestamp,
  modified_by INTEGER NOT NULL REFERENCES users (user_id)
);
COMMENT ON TABLE beers IS 'Information about each beer';

CREATE TABLE ratings (
  rating_id   SERIAL PRIMARY KEY,
  user_id     INTEGER REFERENCES users (user_id) ON DELETE CASCADE,
  beer_id     INTEGER REFERENCES beers (beer_id) ON DELETE CASCADE,
  look        SMALLINT,
  smell       SMALLINT,
  taste       SMALLINT,
  feel        SMALLINT,
  overall     SMALLINT,
  modified_on TIMESTAMP DEFAULT current_timestamp,
  modified_by INTEGER REFERENCES users
);
COMMENT ON TABLE ratings IS 'Ratings for each beer';

CREATE TABLE users (
  user_id     SERIAL PRIMARY KEY,
  name        VARCHAR(50)  NOT NULL,
  email       VARCHAR(100) NOT NULL,
  birthday    DATE         NOT NULL,
  modified_on TIMESTAMP DEFAULT current_timestamp,
  modified_by INTEGER REFERENCES users
);
COMMENT ON TABLE persons IS 'Information about each person';

