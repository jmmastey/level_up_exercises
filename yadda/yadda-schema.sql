-- Usage: psql -d postgres -f yadda/yadda-schema.sql
--   -d database, using default
--   -f sql file to import

-- We will skip this approach in favor of dropping on a per-table basis
-- DROP DATABASE IF EXISTS yadda;
-- CREATE DATABASE yadda;

\connect yadda;

DROP TABLE IF EXISTS persons CASCADE;
CREATE TABLE persons (
  person_id       serial PRIMARY KEY,
  name            varchar(50) NOT NULL,
  email           varchar(100) NOT NULL,
  description     text,
  birthday        date NOT NULL,
  created_at      timestamp with time zone,
  created_by      integer REFERENCES persons(person_id),
  updated_at      timestamp with time zone,
  updated_by      integer REFERENCES persons(person_id),
  CONSTRAINT created_by_key FOREIGN KEY (created_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE persons IS 'Person information';

DROP TABLE IF EXISTS breweries CASCADE;
CREATE TABLE breweries (
  brewery_id      serial PRIMARY KEY,
  name            varchar(250) NOT NULL,
  address         varchar(100),
  city            varchar(50),
  state           char(2),
  postal_code     varchar(20),
  description     text,
  founding_year   integer,
  created_at      timestamp with time zone,
  created_by      integer REFERENCES persons(person_id),
  updated_at      timestamp with time zone,
  updated_by      integer REFERENCES persons(person_id),
  CONSTRAINT created_by_key FOREIGN KEY (created_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE breweries IS 'Brewery information';

DROP TABLE IF EXISTS beers CASCADE;
CREATE TABLE beers (
  beer_id         serial PRIMARY KEY,
  brewery_id      integer NOT NULL,
  name            varchar(250) NOT NULL,
  style_id        integer NOT NULL,
  description     text,
  brewing_year    integer,
  created_at      timestamp with time zone,
  created_by      integer REFERENCES persons(person_id),
  updated_at      timestamp with time zone,
  updated_by      integer REFERENCES persons(person_id),
  CONSTRAINT created_by_key FOREIGN KEY (created_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT brewery_id_key FOREIGN KEY (brewery_id)
    REFERENCES breweries (brewery_id)
    ON DELETE RESTRICT,
  CONSTRAINT style_id_key FOREIGN KEY (style_id)
    REFERENCES styles (style_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE beers IS 'Beer information, many beers to a brewery';

DROP TABLE IF EXISTS styles CASCADE;
CREATE TABLE styles (
  style_id        serial PRIMARY KEY,
  style           varchar(25),
  created_at      timestamp with time zone,
  created_by      integer REFERENCES persons(person_id),
  updated_at      timestamp with time zone,
  updated_by      integer REFERENCES persons(person_id),
  CONSTRAINT created_by_key FOREIGN KEY (created_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE styles IS 'Style information, describes a beer';

DROP TABLE IF EXISTS ratings CASCADE;
CREATE TABLE ratings (
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
  created_by      integer REFERENCES persons(person_id),
  updated_at      timestamp with time zone,
  updated_by      integer REFERENCES persons(person_id),
  CONSTRAINT created_by_key FOREIGN KEY (created_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT person_id_key FOREIGN KEY (person_id)
    REFERENCES persons (person_id)
    ON DELETE RESTRICT,
  CONSTRAINT beer_id_key FOREIGN KEY (beer_id)
    REFERENCES beers (beer_id)
    ON DELETE RESTRICT
);
COMMENT ON TABLE ratings IS 'Rating information, link between person and a beer';
