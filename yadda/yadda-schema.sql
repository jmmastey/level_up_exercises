CREATE TABLE yadda.brewery (
  brewery_id      integer PRIMARY KEY DEFAULT nextval('serial'),
  name            varchar(50) NOT NULL,
  address         varchar(100),
  city            varchar(50),
  state           varchar(2),
  zip_code        integer(9),
  description     text,
  founding_year   date
  modified_on     timestamp DEFAULT current_timestamp
);

CREATE TABLE yadda.beer (
  beer_id         integer PRIMARY KEY DEFAULT nextval('serial'),
  brewery_id      integer(9) references brewery(brewery_id),
  style           varchar(25),
  description     text,
  brewing_year    integer(4),
  modified_on     timestamp DEFAULT current_timestamp
);

CREATE TABLE yadda.user (
  user_id         integer PRIMARY KEY DEFAULT nextval('serial'),
  name            varchar(50) NOT NULL,
  email           varchar(100) NOT NULL,
  description     text,
  birthday        date NOT NULL,
  modified_on     timestamp DEFAULT current_timestamp
);

CREATE TABLE yadda.rating (
  rating_id       integer PRIMARY KEY DEFAULT nextval('serial'),
  user_id         integer(9) references user(user_id),
  beer_id         integer(9) references beer(beer_id),
  look            numeric(3),
  smell           numeric(3),
  taste           numeric(3),
  feel            numeric(3),
  overall         numeric(3),
  description     text,
  modified_on     timestamp DEFAULT current_timestamp
);