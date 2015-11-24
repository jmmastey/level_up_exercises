DROP SCHEMA IF EXISTS yadda CASCADE;

DROP ROLE IF EXISTS yadda_ui;
DROP ROLE IF EXISTS yadda_reports;
DROP ROLE IF EXISTS yadda_ro;
DROP ROLE IF EXISTS yadda_rw;


CREATE ROLE yadda_ro;
CREATE ROLE yadda_reports WITH LOGIN PASSWORD 'businessreports' IN ROLE yadda_ro;
COMMENT ON ROLE yadda_ro IS 'Inheritable role for reading data from the system.';
COMMENT ON ROLE yadda_reports IS 'Login role for generating reports.';

CREATE ROLE yadda_rw;
CREATE ROLE yadda_ui WITH LOGIN PASSWORD 'yaddayaddayadda' IN ROLE yadda_rw;
COMMENT ON ROLE yadda_rw IS 'Inheritable role for reading/writing/deleting data on the system.';
COMMENT ON ROLE yadda_ui IS 'Login role for the user interface to interact with the system.';

CREATE SCHEMA yadda;
GRANT USAGE ON SCHEMA yadda TO yadda_ro;
GRANT USAGE ON SCHEMA yadda TO yadda_rw;
COMMENT ON SCHEMA yadda IS 'Contains all read-writable data maintained by via the Yadda web site.';

CREATE OR REPLACE FUNCTION yadda.set_updated_timestamp()
  RETURNS TRIGGER
  LANGUAGE plpgsql
AS $$
BEGIN
  NEW.update_timestamp := now();
  RETURN NEW;
END;
$$;

CREATE TABLE yadda.breweries (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  description TEXT NOT NULL,
  founding_year INTEGER CONSTRAINT valid_founding_year CHECK (founding_year >= 725) NOT NULL,
  insert_user_id INTEGER NOT NULL,
  update_user_id INTEGER NOT NULL,
  insert_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  update_timestamp TIMESTAMP NOT NULL
);
GRANT SELECT ON yadda.breweries TO yadda_ro;
GRANT ALL PRIVILEGES ON yadda.breweries TO yadda_rw;
REVOKE TRUNCATE ON yadda.breweries FROM yadda_rw;

COMMENT ON CONSTRAINT valid_founding_year ON yadda.breweries IS 'Brewery must not be older than Weihenstephan, the oldest brewery.  As an aside, they have an excellent Hefeweissbier.';

CREATE TRIGGER test_table_update_timestamp
  BEFORE UPDATE OR INSERT ON yadda.breweries
  FOR EACH ROW EXECUTE PROCEDURE yadda.set_updated_timestamp();
GRANT USAGE ON yadda.breweries_id_seq TO yadda_rw;

CREATE TABLE yadda.brews (
  id SERIAL PRIMARY KEY,
  brewery_id INTEGER NOT NULL REFERENCES yadda.breweries,
  style TEXT NOT NULL,
  description TEXT NOT NULL,
  year INTEGER NOT NULL CONSTRAINT valid_brewing_year CHECK (year >= -7000),
  insert_user_id INTEGER NOT NULL,
  update_user_id INTEGER NOT NULL,
  insert_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  update_timestamp TIMESTAMP NOT NULL
);
GRANT SELECT ON yadda.brews TO yadda_ro;
GRANT ALL PRIVILEGES ON yadda.brews TO yadda_rw;
REVOKE TRUNCATE ON yadda.brews FROM yadda_rw;

COMMENT ON COLUMN yadda.brews.style IS 'E.g. Stout, India Pale Ale, Saison.';
COMMENT ON CONSTRAINT valid_brewing_year ON yadda.brews IS 'Brew must not be older than the oldest beer ever found.';

CREATE TRIGGER test_table_update_timestamp
  BEFORE UPDATE OR INSERT ON yadda.brews
  FOR EACH ROW EXECUTE PROCEDURE yadda.set_updated_timestamp();
GRANT USAGE ON yadda.brews_id_seq TO yadda_rw;


CREATE TABLE yadda.users (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  address TEXT NOT NULL,
  email_address TEXT NOT NULL,
  birth_date DATE NOT NULL CONSTRAINT valid_birth_date CHECK (birth_date >= '1899-07-06') CONSTRAINT can_drink CHECK (birth_date <= now() - interval '21 years'),
  insert_user_id INTEGER NOT NULL,
  update_user_id INTEGER NOT NULL,
  insert_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  update_timestamp TIMESTAMP NOT NULL
);
GRANT SELECT ON yadda.users TO yadda_ro;
GRANT ALL PRIVILEGES ON yadda.users TO yadda_rw;
REVOKE TRUNCATE ON yadda.users FROM yadda_rw;

COMMENT ON COLUMN yadda.users.address IS 'User''s full address, including their state, zip code, country, etc - whatever is applicable for their region.';
COMMENT ON CONSTRAINT valid_birth_date ON yadda.users IS 'User must be no older than the oldest living person.';
COMMENT ON CONSTRAINT can_drink ON yadda.users IS 'User must be at least 21 years old.';

CREATE TRIGGER test_table_update_timestamp
  BEFORE UPDATE OR INSERT ON yadda.users
  FOR EACH ROW EXECUTE PROCEDURE yadda.set_updated_timestamp();
GRANT USAGE ON yadda.users_id_seq TO yadda_rw;


CREATE TABLE yadda.ratings (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES yadda.users (id),
  brew_id INTEGER NOT NULL REFERENCES yadda.brews (id),
  look_rating INTEGER NOT NULL CONSTRAINT valid_look_rating CHECK (look_rating >= 1 AND look_rating <= 5),
  smell_rating INTEGER NOT NULL CONSTRAINT valid_smell_rating CHECK (smell_rating >= 1 AND smell_rating <= 5),
  taste_rating INTEGER NOT NULL CONSTRAINT valid_taste_rating CHECK (taste_rating >= 1 AND taste_rating <= 5),
  feel_rating INTEGER NOT NULL CONSTRAINT valid_feel_rating CHECK (feel_rating >= 1 AND feel_rating <= 5),
  overall_rating INTEGER NOT NULL CONSTRAINT valid_overall_rating CHECK (overall_rating >= 1 AND overall_rating <= 5),
  insert_user_id INTEGER NOT NULL,
  update_user_id INTEGER NOT NULL,
  insert_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  update_timestamp TIMESTAMP NOT NULL
);
GRANT SELECT ON yadda.ratings TO yadda_ro;
GRANT ALL PRIVILEGES ON yadda.ratings TO yadda_rw;
REVOKE TRUNCATE ON yadda.ratings FROM yadda_rw;

COMMENT ON COLUMN yadda.ratings.overall_rating IS 'The overall rating is user-specified, and is not an average.';
COMMENT ON CONSTRAINT valid_look_rating ON yadda.ratings IS 'Rating must be between 1 and 5 stars, inclusive.';
COMMENT ON CONSTRAINT valid_smell_rating ON yadda.ratings IS 'Rating must be between 1 and 5 stars, inclusive.';
COMMENT ON CONSTRAINT valid_taste_rating ON yadda.ratings IS 'Rating must be between 1 and 5 stars, inclusive.';
COMMENT ON CONSTRAINT valid_feel_rating ON yadda.ratings IS 'Rating must be between 1 and 5 stars, inclusive.';
COMMENT ON CONSTRAINT valid_overall_rating ON yadda.ratings IS 'Rating must be between 1 and 5 stars, inclusive.';

CREATE TRIGGER test_table_update_timestamp
  BEFORE UPDATE OR INSERT ON yadda.ratings
  FOR EACH ROW EXECUTE PROCEDURE yadda.set_updated_timestamp();
GRANT USAGE ON yadda.ratings_id_seq TO yadda_rw;