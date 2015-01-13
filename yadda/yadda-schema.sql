DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;

CREATE TABLE brewery (
  brewery_id      serial PRIMARY KEY,
  name            varchar(50) NOT NULL,
  address         varchar(100),
  city            varchar(50),
  state           varchar(2),
  zip_code        integer,
  description     text,
  founding_year   integer,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer REFERENCES person
);
CREATE UNIQUE INDEX brewery_id_index ON brewery(brewery_id);
COMMENT ON TABLE brewery IS 'Brewery information';

CREATE TABLE beer (
  beer_id         serial PRIMARY KEY,
  brewery_id      integer REFERENCES brewery,
  style           varchar(25),
  description     text,
  brewing_year    integer,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer REFERENCES person
);
CREATE UNIQUE INDEX beer_id_to_brewery_id_index ON beer(beer_id, brewery_id);
COMMENT ON TABLE beer IS 'Beer information, many beers to a brewery';

CREATE TABLE person (
  person_id       serial PRIMARY KEY,
  name            varchar(50) NOT NULL,
  email           varchar(100) NOT NULL,
  description     text,
  birthday        date NOT NULL,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer REFERENCES person
);
CREATE UNIQUE INDEX person_id_index ON person(person_id);
COMMENT ON TABLE person IS 'person information';

CREATE TABLE rating (
  rating_id       serial PRIMARY KEY,
  person_id       integer REFERENCES person,
  beer_id         integer REFERENCES beer,
  look            numeric(3) CHECK (look > 0),
  smell           numeric(3) CHECK (smell > 0),
  taste           numeric(3) CHECK (taste > 0),
  feel            numeric(3) CHECK (feel > 0),
  overall         numeric(3) CHECK (overall > 0) NOT NULL,
  description     text,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer REFERENCES person
);
CREATE UNIQUE INDEX rating_id_index ON rating(rating_id);
CREATE UNIQUE INDEX person_to_beer_index ON rating(person_id, beer_id);
COMMENT ON TABLE rating IS 'Rating information, link between a person and a beer';
