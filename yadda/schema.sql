DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;
\connect yadda;

CREATE TABLE users (
  id            SERIAL                   PRIMARY KEY,
  created_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  updated_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  name          VARCHAR(100)             NOT NULL,
  email         VARCHAR(100)             NOT NULL,
  password_hash VARCHAR(100)             NOT NULL,
  city          VARCHAR(50),
  state         VARCHAR(2)
);

CREATE TABLE breweries (
  id            SERIAL                   PRIMARY KEY,
  created_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  created_by    INTEGER                  NOT NULL REFERENCES users ON DELETE RESTRICT,
  updated_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  updated_by    INTEGER                  NOT NULL REFERENCES users ON DELETE RESTRICT,
  name          VARCHAR(100) NOT NULL,
  description   TEXT,
  address1      VARCHAR(100),
  address2      VARCHAR(100),
  city          VARCHAR(50),
  state         VARCHAR(2),
  zip_code      VARCHAR(5),
  year_founded  SMALLINT
);

CREATE TABLE beer_styles (
  id            SERIAL                   PRIMARY KEY,
  created_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  created_by    INTEGER                  NOT NULL REFERENCES users ON DELETE RESTRICT,
  updated_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  updated_by    INTEGER                  NOT NULL REFERENCES users ON DELETE RESTRICT,
  name          VARCHAR(100)             NOT NULL
);

CREATE TABLE beers (
  id            SERIAL                   PRIMARY KEY,
  brewery_id    INTEGER                  NOT NULL REFERENCES breweries ON DELETE CASCADE,
  beer_style_id INTEGER                  NOT NULL REFERENCES beer_styles ON DELETE RESTRICT,
  created_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  created_by    INTEGER                  NOT NULL REFERENCES users ON DELETE RESTRICT,
  updated_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  updated_by    INTEGER                  NOT NULL REFERENCES users ON DELETE RESTRICT,
  name          VARCHAR(100)             NOT NULL,
  description   TEXT,
  year_brewed   SMALLINT
);

CREATE TABLE ratings (
  id            SERIAL                   PRIMARY KEY,
  user_id       INTEGER                  NOT NULL REFERENCES users ON DELETE CASCADE,
  beer_id       INTEGER                  NOT NULL REFERENCES beers ON DELETE CASCADE,
  created_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  updated_on    TIMESTAMP WITH TIME ZONE NOT NULL,
  appearance    SMALLINT                 NOT NULL,
  aroma         SMALLINT                 NOT NULL,
  taste         SMALLINT                 NOT NULL,
  texture       SMALLINT                 NOT NULL,
  overall       SMALLINT                 NOT NULL,
  notes         TEXT
);
