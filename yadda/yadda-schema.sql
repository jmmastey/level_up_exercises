DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;

\connect yadda;

--TODO cascading/restricting deletes

CREATE TABLE person (
  person_id       serial PRIMARY KEY,
  name            varchar(50) NOT NULL,
  email           varchar(100) NOT NULL,
  description     text,
  birthday        date NOT NULL,
  updated_at      timestamp with time zone,
  updated_by      integer NOT NULL,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES person (person_id)
);
COMMENT ON TABLE person IS 'Person information';

CREATE TABLE brewery (
  brewery_id      serial PRIMARY KEY,
  name            varchar(250) NOT NULL,
  address         varchar(100),
  city            varchar(50),
  state           char(2),
  postal_code     varchar(20),
  description     text,
  founding_year   integer,
  updated_at      timestamp with time zone,
  updated_by      integer NOT NULL,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES person (person_id)
);
COMMENT ON TABLE brewery IS 'Brewery information';

CREATE TABLE beer (
  beer_id         serial PRIMARY KEY,
  brewery_id      integer NOT NULL,
  name            varchar(250) NOT NULL,
  style           varchar(25),
  description     text,
  brewing_year    integer,
  updated_at      timestamp with time zone,
  updated_by      integer NOT NULL,
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES person (person_id),
  CONSTRAINT brewery_id_key FOREIGN KEY (brewery_id)
    REFERENCES brewery (brewery_id)
);
COMMENT ON TABLE beer IS 'Beer information, many beers to a brewery';

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
  updated_at      timestamp with time zone,
  updated_by      integer REFERENCES person(person_id),
  CONSTRAINT updated_by_key FOREIGN KEY (updated_by)
    REFERENCES person (person_id),
  CONSTRAINT person_id_key FOREIGN KEY (person_id)
    REFERENCES person (person_id),
  CONSTRAINT beer_id_key FOREIGN KEY (beer_id)
    REFERENCES beer (beer_id)
);
COMMENT ON TABLE rating IS 'Rating information, link between a person and a beer';
