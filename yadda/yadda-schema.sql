CREATE TABLE yadda.brewery (
  brewery_id      integer PRIMARY KEY DEFAULT nextval('serial'),
  name            varchar(50) NOT NULL,
  address         varchar(100),
  city            varchar(50),
  state           varchar(2),
  zip_code        integer(9),
  description     text,
  founding_year   date
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer(9) REFERENCES user
);
CREATE INDEX brewery_id_index ON brewery(brewery_id);
COMMENT ON TABLE brewery IS 'Brewery information';

CREATE TABLE yadda.beer (
  beer_id         integer PRIMARY KEY DEFAULT nextval('serial'),
  brewery_id      integer(9) REFERENCES brewery,
  style           varchar(25),
  description     text,
  brewing_year    integer(4),
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer(9) REFERENCES user
);
CREATE INDEX beer_id_index ON beer(beer_id);
COMMENT ON TABLE beer IS 'Beer information, many beers to a brewery';

CREATE TABLE yadda.user (
  user_id         integer PRIMARY KEY DEFAULT nextval('serial'),
  name            varchar(50) NOT NULL,
  email           varchar(100) NOT NULL,
  description     text,
  birthday        date NOT NULL,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer(9) REFERENCES user
);
CREATE INDEX user_id_index ON user(user_id);
COMMENT ON TABLE user IS 'User information';

CREATE TABLE yadda.rating (
  rating_id       integer PRIMARY KEY DEFAULT nextval('serial'),
  user_id         integer(9) REFERENCES user,
  beer_id         integer(9) REFERENCES beer,
  look            numeric(3) CHECK (look > 0),
  smell           numeric(3) CHECK (smell > 0),
  taste           numeric(3) CHECK (taste > 0),
  feel            numeric(3) CHECK (feel > 0),
  overall         numeric(3) CHECK (overall > 0) NOT NULL,
  description     text,
  modified_on     timestamp DEFAULT current_timestamp,
  modified_by     integer(9) REFERENCES user
);
CREATE INDEX rating_id_index ON rating(rating_id);
CREATE INDEX user_to_beer_index ON rating(user_id, beer_id);
COMMENT ON TABLE rating IS 'Rating information, link between a user and a beer';
