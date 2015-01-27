BEGIN;

CREATE SCHEMA IF NOT EXISTS yadda AUTHORIZATION sastaputhra;

CREATE TABLE yadda.addresses(
  id            SERIAL       PRIMARY KEY,
  line_1        TEXT         NOT NULL,
  line_2        TEXT,
  state         TEXT         NOT NULL,
  country       TEXT         NOT NULL,
  zip_code      TEXT         NOT NULL,
  created_by   TEXT         ,
  created_on   TIMESTAMPTZ  ,
  updated_by    TEXT         ,
  updated_on    TIMESTAMPTZ
);

CREATE TABLE yadda.breweries(
  id            SERIAL       PRIMARY KEY,
  name          TEXT         NOT NULL,
  address_id    INTEGER      NOT NULL REFERENCES yadda.addresses,
  founding_year INTEGER      NOT NULL,
  created_by   TEXT         ,
  created_on   TIMESTAMPTZ  ,
  updated_by    TEXT         ,
  updated_on    TIMESTAMPTZ  ,
  description   TEXT
  );

CREATE TABLE yadda.beers(
  id            SERIAL       PRIMARY KEY,
  style         TEXT         NOT NULL,
  brewing_year  INTEGER      NOT NULL,
  brewery_id    INTEGER      REFERENCES yadda.breweries,
  created_by   TEXT         ,
  created_on   TIMESTAMPTZ  ,
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
  created_by    TEXT         ,
  created_on    TIMESTAMPTZ  ,
  updated_by    TEXT         ,
  updated_on    TIMESTAMPTZ
);

CREATE TABLE yadda.ratings(
  id            SERIAL       PRIMARY KEY,
  beer_id       INTEGER      REFERENCES yadda.beers,
  user_id       INTEGER      REFERENCES yadda.users,
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
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION  yadda.tg_updates()
RETURNS TRIGGER AS $$
  BEGIN
    NEW.updated_on := current_timestamp;
    NEW.updated_by := current_user;
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

COMMIT;


