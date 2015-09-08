DROP DATABASE IF EXISTS yadda CASCADE;
CREATE DATABASE yadda;
\connect yadda;

CREATE TABLE users (
  id              SERIAL                    PRIMARY KEY,
  name            VARCHAR(40)               NOT NULL,
  email           VARCHAR(100)              NOT NULL,
  birthday        DATE                      NOT NULL,
  password        VARCHAR(50)               NOT NULL,
  modified_on     TIMESTAMP WITH TIME ZONE  NOT NULL DEFAULT current_time,
  modified_by     VARCHAR(50),
  created_on      TIMESTAMP WITH TIME ZONE  NOT NULL DEFAULT current_time,
  created_by      VARCHAR(50)
);

CREATE TABLE breweries (
  id              SERIAL                    PRIMARY KEY,
  name            TEXT                      NOT NULL,
  address_id      INTEGER                   NOT NULL,
  description     TEXT                      NOT NULL,
  founding_year   INTEGER                   NOT NULL,
  modified_on     TIMESTAMP WITH TIME ZONE  NOT NULL DEFAULT current_time,
  modified_by     VARCHAR(50),
  created_on      TIMESTAMP WITH TIME ZONE  NOT NULL DEFAULT current_time,
  created_by      VARCHAR(50)
);

CREATE TABLE styles (
  id              SERIAL                    PRIMARY KEY,
  style           VARCHAR(50)               NOT NULL
);

CREATE TABLE beers (
  id              SERIAL                    PRIMARY KEY,
  name            VARCHAR(100)              NOT NULL,
  style_id        INTEGER                   NOT NULL REFERENCES styles (id) ON DELETE SET NULL,
  description     TEXT                      NOT NULL,
  brew_year       INTEGER                   NOT NULL,
  brewery_id      INTEGER                   NOT NULL REFERENCES breweries ON DELETE CASCADE,
  modified_on     TIMESTAMP WITH TIME ZONE  NOT NULL DEFAULT current_time,
  modified_by     VARCHAR(50),
  created_on      TIMESTAMP WITH TIME ZONE  NOT NULL DEFAULT current_time,
  created_by      VARCHAR(50)
);

CREATE TABLE ratings (
  id              SERIAL                    PRIMARY KEY,
  user_id         INTEGER                   NOT NULL REFERENCES users (id) ON DELETE CASCADE,
  beer_id         INTEGER                   NOT NULL REFERENCES beers (id) ON DELETE CASCADE,
  look            SMALLINT                  NOT NULL CHECK ( look > 0 AND look < 11),
  smell           SMALLINT                  NOT NULL CHECK ( smell > 0 AND smell < 11),
  taste           SMALLINT                  NOT NULL CHECK ( taste > 0 AND taste < 11),
  overall         SMALLINT                  NOT NULL CHECK ( overall > 0 AND overall < 11),
  modified_on     TIMESTAMP WITH TIME ZONE  NOT NULL DEFAULT current_time,
  modified_by     VARCHAR(50),
  created_on      TIMESTAMP WITH TIME ZONE  NOT NULL DEFAULT current_time,
  created_by      VARCHAR(50)
);