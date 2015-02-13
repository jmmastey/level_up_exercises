-- Usage: psql -d postgres -f yadda/yadda-schema.sql
--   -d database, using default
--   -f sql file to import

-- We will skip this approach in favor of dropping on a per-table basis
-- DROP DATABASE IF EXISTS yadda;
-- CREATE DATABASE yadda;

\connect yadda;

DROP TABLE IF EXISTS person CASCADE;
CREATE TABLE person (
  person_id       serial PRIMARY KEY,
  name            varchar(50) NOT NULL,
  email           varchar(100) NOT NULL,
  description     text,
  birthday        date NOT NULL,
  created_at      timestamp with time zone,
  updated_at      timestamp with time zone,
  updated_by      integer NOT NULL,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES person (person_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE person IS 'Person information';

DROP TABLE IF EXISTS brewery CASCADE;
CREATE TABLE brewery (
  brewery_id      serial PRIMARY KEY,
  name            varchar(250) NOT NULL,
  address         varchar(100),
  city            varchar(50),
  state           char(2),
  postal_code     varchar(20),
  description     text,
  founding_year   integer,
  created_at      timestamp with time zone,
  updated_at      timestamp with time zone,
  updated_by      integer NOT NULL,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES person (person_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE brewery IS 'Brewery information';

DROP TABLE IF EXISTS beer CASCADE;
CREATE TABLE beer (
  beer_id         serial PRIMARY KEY,
  brewery_id      integer NOT NULL,
  name            varchar(250) NOT NULL,
  style           varchar(25),
  description     text,
  brewing_year    integer,
  created_at      timestamp with time zone,
  updated_at      timestamp with time zone,
  updated_by      integer NOT NULL,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES person (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT brewery_id_key FOREIGN KEY (brewery_id)
    REFERENCES brewery (brewery_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE beer IS 'Beer information, many beers to a brewery';

DROP TABLE IF EXISTS rating CASCADE;
CREATE TABLE rating (
  rating_id       serial PRIMARY KEY,
  person_id       integer NOT NULL,
  beer_id         integer NOT NULL,
  look            numeric(3),
  smell           numeric(3),
  taste           numeric(3),
  feel            numeric(3),
  overall         numeric(3) NOT NULL,
  description     text,
  created_at      timestamp with time zone,
  updated_at      timestamp with time zone,
  updated_by      integer REFERENCES person(person_id),
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES person (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT person_id_key FOREIGN KEY (person_id)
    REFERENCES person (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT beer_id_key FOREIGN KEY (beer_id)
    REFERENCES beer (beer_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE rating IS 'Rating information, link between person and a beer';
