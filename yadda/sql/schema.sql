DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;
\c yadda

CREATE TABLE addresses
(
  id                          SERIAL                          PRIMARY KEY,
  address_line_1              VARCHAR(100)                    NOT NULL,
  address_line_2              VARCHAR(100)                    ,
  city                        VARCHAR(100)                    NOT NULL,
  state                       VARCHAR(2)                      NOT NULL,
  zipcode                     VARCHAR(5)                      NOT NULL,
  country                     VARCHAR(100)                    NOT NULL,
  created_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by                  VARCHAR(30)                     NOT NULL,
  updated_by                  VARCHAR(30)
);

CREATE TABLE breweries
(
  id                          SERIAL                          PRIMARY KEY,
  name                        TEXT                            NOT NULL,
  address_id                  INTEGER                         NOT NULL REFERENCES addresses ON DELETE CASCADE, -- remove all breweries located at the address
  description                 TEXT                            NOT NULL,
  founding_year               SMALLINT                        NOT NULL,
  created_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by                  VARCHAR(30)                     NOT NULL,
  updated_by                  VARCHAR(30)
);

CREATE TABLE beer_styles
(
  id                          SERIAL                          PRIMARY KEY,
  name                        VARCHAR(50)                     NOT NULL UNIQUE,
  created_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by                  VARCHAR(30)                     NOT NULL,
  updated_by                  VARCHAR(30)
);

CREATE TABLE beers
(
  id                          SERIAL                          PRIMARY KEY,
  name                        VARCHAR(50)                     NOT NULL,
  beer_style_id               INTEGER                         NOT NULL REFERENCES beer_styles ON DELETE RESTRICT, -- beer style should not be deleted if beer still has that style
  description                 TEXT                            ,
  brewing_year                SMALLINT                        NOT NULL,
  brewery_id                  INTEGER                         NOT NULL REFERENCES breweries ON DELETE CASCADE, -- remove all beers assocated with a deleted brewery
  created_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by                  VARCHAR(30)                     NOT NULL,
  updated_by                  VARCHAR(30)
);

CREATE TABLE users
(
  id                          SERIAL                          PRIMARY KEY,
  fname                       VARCHAR(50)                     NOT NULL,
  lname                       VARCHAR(50)                     NOT NULL,
  username                    VARCHAR(50)                     NOT NULL,
  age                         SMALLINT                        ,
  weight_in_lbs               SMALLINT                        ,
  height_in_inches            SMALLINT                        ,
  email                       VARCHAR(200)                    ,
  address_id                  INTEGER                         NOT NULL REFERENCES addresses ON DELETE CASCADE, -- remove all users located at the address
  created_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by                  VARCHAR(30)                     NOT NULL,
  updated_by                  VARCHAR(30)
);

CREATE TABLE ratings
(
  id                          SERIAL                          PRIMARY KEY,
  user_id                     INTEGER                         NOT NULL REFERENCES users ON DELETE RESTRICT, -- rating should not be deleted if user still exists
  beer_id                     INTEGER                         NOT NULL REFERENCES beers ON DELETE RESTRICT, -- rating should not be deleted if beer still exists
  look                        NUMERIC(3,2)                    CHECK (look BETWEEN 0 AND 5) DEFAULT 0,
  smell                       NUMERIC(3,2)                    CHECK (look BETWEEN 0 AND 5) DEFAULT 0,
  taste                       NUMERIC(3,2)                    CHECK (look BETWEEN 0 AND 5) DEFAULT 0,
  feel                        NUMERIC(3,2)                    CHECK (look BETWEEN 0 AND 5) DEFAULT 0,
  overall                     NUMERIC(3,2)                    CHECK (look BETWEEN 0 AND 5) DEFAULT 0,
  notes                       TEXT                            ,
  created_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_on                  TIMESTAMP WITH TIME ZONE        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by                  VARCHAR(30)                     NOT NULL,
  updated_by                  VARCHAR(30)
);

CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
   IF row(NEW.*) IS DISTINCT FROM row(OLD.*) THEN
      NEW.updated_on = now();
      RETURN NEW;
   ELSE
      RETURN OLD;
   END IF;
END;
$$ language 'plpgsql';

-- Apply function to each table to automatically set the updated_on column
-- for each update query

CREATE TRIGGER update_timestamp BEFORE UPDATE ON addresses FOR
EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_timestamp BEFORE UPDATE ON beer_styles FOR
EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_timestamp BEFORE UPDATE ON users FOR
EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_timestamp BEFORE UPDATE ON breweries FOR
EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_timestamp BEFORE UPDATE ON beers FOR
EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_timestamp BEFORE UPDATE ON ratings FOR
EACH ROW EXECUTE PROCEDURE update_timestamp();


CREATE INDEX ratings_beer_id_index ON ratings(beer_id);

CREATE INDEX beers_beer_style_id_index ON beers(beer_style_id);

CREATE INDEX beers_brewery_id_index ON beers(brewery_id);

CREATE INDEX ratings_created_on_index ON ratings(created_on);

CREATE INDEX beers_styles_name_index ON beer_styles(name);
