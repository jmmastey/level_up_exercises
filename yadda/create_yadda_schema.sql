BEGIN;

CREATE SCHEMA IF NOT EXISTS yadda AUTHORIZATION sastaputhra;

DROP TABLE IF EXISTS yadda.addresses CASCADE;
DROP TABLE IF EXISTS yadda.breweries CASCADE;
DROP TABLE IF EXISTS yadda.beers CASCADE;
DROP TABLE IF EXISTS yadda.users CASCADE;
DROP TABLE IF EXISTS yadda.ratings CASCADE;
DROP TABLE IF EXISTS yadda.beer_styles CASCADE;

CREATE TABLE yadda.addresses(
  id            SERIAL       PRIMARY KEY,
  line_1        TEXT         NOT NULL,
  line_2        TEXT,
  city          TEXT,
  state         TEXT,
  country       TEXT,
  zip_code      TEXT,
  created_by    TEXT         ,
  created_on    TIMESTAMPTZ  ,
  updated_by    TEXT         ,
  updated_on    TIMESTAMPTZ
);

CREATE TABLE yadda.breweries(
  id            SERIAL       PRIMARY KEY,
  name          TEXT         NOT NULL,
  address_id    INTEGER      NOT NULL REFERENCES yadda.addresses ON DELETE CASCADE,
  founding_year INTEGER      NOT NULL,
  created_by    TEXT         ,
  created_on    TIMESTAMPTZ  ,
  updated_by    TEXT         ,
  updated_on    TIMESTAMPTZ  ,
  description   TEXT
  );

CREATE TABLE yadda.beer_categories(
  id            SERIAL       PRIMARY KEY,
  category      TEXT         NOT NULL
);

CREATE TABLE yadda.beer_styles(
  id            SERIAL       PRIMARY KEY,
  category_id   INTEGER      NOT NULL REFERENCES yadda.beer_categories ON DELETE CASCADE,
  style         TEXT         NOT NULL
);

CREATE TABLE yadda.beers(
  id            SERIAL       PRIMARY KEY,
  style_id      INTEGER      NOT NULL REFERENCES yadda.beer_styles ON DELETE CASCADE,
  brewing_year  INTEGER      NOT NULL,
  brewery_id    INTEGER      REFERENCES yadda.breweries ON DELETE CASCADE,
  created_by    TEXT         ,
  created_on    TIMESTAMPTZ  ,
  updated_by    TEXT         ,
  updated_on    TIMESTAMPTZ  ,
  description   TEXT
);

CREATE TABLE yadda.users(
  id            SERIAL       PRIMARY KEY,
  name          TEXT         NOT NULL,
  email         TEXT,
  password      TEXT,
  phone         TEXT,
  address_id    INTEGER      NOT NULL REFERENCES yadda.addresses ON DELETE CASCADE,
  created_by    TEXT         ,
  created_on    TIMESTAMPTZ  ,
  updated_by    TEXT         ,
  updated_on    TIMESTAMPTZ
);

CREATE TABLE yadda.ratings(
  id            SERIAL       PRIMARY KEY,
  beer_id       INTEGER      REFERENCES yadda.beers ON DELETE CASCADE,
  user_id       INTEGER      REFERENCES yadda.users ON DELETE CASCADE,
  look          INTEGER      NOT NULL CHECK(look between 0 AND 5),
  smell         INTEGER      NOT NULL CHECK(smell between 0 AND 5),
  taste         INTEGER      NOT NULL CHECK(taste between 0 AND 5),
  feel          INTEGER      NOT NULL CHECK(feel between 0 AND 5),
  overall       INTEGER      NOT NULL CHECK(overall between 0 AND 5),
  created_by    TEXT         ,
  created_on    TIMESTAMPTZ  ,
  updated_by    TEXT         ,
  updated_on    TIMESTAMPTZ
);

CREATE OR REPLACE FUNCTION  yadda.tg_inserts()
RETURNS TRIGGER AS $$
  BEGIN
    NEW.created_on := current_timestamp;
    NEW.created_by := current_user;
    -- While inserting/creating a record only created_* are populated
    -- as we are not updating, anything the updated_* columns are left blank
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION  yadda.tg_updates()
RETURNS TRIGGER AS $$
  BEGIN
    NEW.updated_on := current_timestamp;
    NEW.updated_by := current_user;
    -- While updating a record only updated_* are populated
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_address_inserts ON yadda.addresses;

CREATE TRIGGER check_address_inserts
  BEFORE INSERT
  ON yadda.addresses
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_inserts();

DROP TRIGGER IF EXISTS check_breweries_inserts ON yadda.breweries;

CREATE TRIGGER check_breweries_inserts
  BEFORE INSERT
  ON yadda.breweries
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_inserts();

DROP TRIGGER IF EXISTS check_beers_inserts ON yadda.breweries;

CREATE TRIGGER check_beers_inserts
  BEFORE INSERT
  ON yadda.beers
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_inserts();

DROP TRIGGER IF EXISTS check_ratings_inserts ON yadda.breweries;

CREATE TRIGGER check_ratings_inserts
  BEFORE INSERT
  ON yadda.ratings
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_inserts();


DROP TRIGGER IF EXISTS check_users_inserts ON yadda.breweries;

CREATE TRIGGER check_users_inserts
  BEFORE INSERT
  ON yadda.users
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_inserts();

DROP TRIGGER IF EXISTS check_address_inserts ON yadda.addresses;

CREATE TRIGGER check_address_updates
  BEFORE UPDATE
  ON yadda.addresses
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_updates();

DROP TRIGGER IF EXISTS check_breweries_updates ON yadda.breweries;

CREATE TRIGGER check_breweries_updates
  BEFORE UPDATE
  ON yadda.breweries
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_updates();

DROP TRIGGER IF EXISTS check_beers_updates ON yadda.breweries;

CREATE TRIGGER check_beers_updates
  BEFORE UPDATE
  ON yadda.beers
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_updates();

DROP TRIGGER IF EXISTS check_users_updates ON yadda.breweries;

CREATE TRIGGER check_users_updates
  BEFORE UPDATE
  ON yadda.users
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_updates();

DROP TRIGGER IF EXISTS check_ratings_updates ON yadda.breweries;

CREATE TRIGGER check_ratings_updates
  BEFORE UPDATE
  ON yadda.ratings
  FOR EACH ROW EXECUTE PROCEDURE yadda.tg_updates();
COMMIT;


