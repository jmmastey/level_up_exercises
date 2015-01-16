DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;

\connect yadda;

CREATE TABLE person (
  person_id       serial PRIMARY KEY,
  name            varchar(50) NOT NULL,
  email           varchar(100) NOT NULL,
  description     text,
  birthday        date NOT NULL,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer NOT NULL,
  CONSTRAINT modified_by_key FOREIGN KEY (modified_by)
    REFERENCES person (person_id)
);
COMMENT ON TABLE person IS 'person information';

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
  modified_by     integer NOT NULL,
  CONSTRAINT modified_by_key FOREIGN KEY (modified_by)
    REFERENCES person (person_id)
);
COMMENT ON TABLE brewery IS 'Brewery information';

CREATE TABLE beer (
  beer_id         serial PRIMARY KEY,
  brewery_id      integer NOT NULL,
  style           varchar(25),
  description     text,
  brewing_year    integer,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer NOT NULL,
  CONSTRAINT modified_by_key FOREIGN KEY (modified_by)
    REFERENCES person (person_id),
  CONSTRAINT brewery_id_key FOREIGN KEY (brewery_id)
    REFERENCES brewery (brewery_id)
);
COMMENT ON TABLE beer IS 'Beer information, many beers to a brewery';

CREATE TABLE rating (
  rating_id       serial PRIMARY KEY,
  person_id       integer NOT NULL,
  beer_id         integer NOT NULL,
  look            numeric(3) CHECK (look > 0),
  smell           numeric(3) CHECK (smell > 0),
  taste           numeric(3) CHECK (taste > 0),
  feel            numeric(3) CHECK (feel > 0),
  overall         numeric(3) CHECK (overall > 0) NOT NULL,
  description     text,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer REFERENCES person(person_id),
  CONSTRAINT modified_by_key FOREIGN KEY (modified_by)
    REFERENCES person (person_id),
  CONSTRAINT person_id_key FOREIGN KEY (person_id)
    REFERENCES person (person_id),
  CONSTRAINT beer_id_key FOREIGN KEY (beer_id)
    REFERENCES beer (beer_id)
);
COMMENT ON TABLE rating IS 'Rating information, link between a person and a beer';
