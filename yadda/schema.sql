CREATE TABLE addresses (
  id integer PRIMARY KEY,
  address_line_1 varchar(50) NOT NULL,
  address_line_2 varchar(50),
  city varchar(50) NOT NULL,
  region varchar(10) NOT NULL,
  postal_code varchar(10) NOT NULL,
  country varchar(50) NOT NULL,
  created_at timestamp without time zone NOT NULL,
  created_by varchar(40) NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar(40)
);

CREATE TABLE breweries (
  id integer PRIMARY KEY,
  name varchar(30) NOT NULL,
  description text NOT NULL,
  address_id integer NOT NULL,
  created_at timestamp without time zone NOT NULL,
  created_by varchar(40) NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar(40),
  CONSTRAINT brewery_address_id_fkey FOREIGN KEY (address_id)
    REFERENCES addresses (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE users (
  id integer PRIMARY KEY,
  username varchar(40) NOT NULL UNIQUE,
  email varchar(40) NOT NULL UNIQUE,
  encrypted_password varchar(40) NOT NULL,
  reset_password_token varchar(40),
  reset_password_sent_at timestamp without time zone,
  active boolean NOT NULL,
  sign_in_count integer DEFAULT 0 NOT NULL,
  location varchar(40),
  created_at timestamp without time zone NOT NULL,
  created_by varchar(40) NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar(40)
);

CREATE TABLE beers (
  id integer PRIMARY KEY,
  style varchar(40) NOT NULL,
  description text NOT NULL,
  year char(4) NOT NULL,
  brewery_id integer NOT NULL,
  created_at timestamp without time zone NOT NULL,
  created_by varchar(40) NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar(40),
  CONSTRAINT beer_brewery_id_fkey FOREIGN KEY (brewery_id)
    REFERENCES breweries (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ratings (
  id integer PRIMARY KEY,
  look smallint NOT NULL,
  smell smallint NOT NULL,
  taste smallint NOT NULL,
  feel smallint NOT NULL,
  overall smallint NOT NULL,
  beer_id integer NOT NULL,                   -- Beer to be rated
  user_id integer NOT NULL,                   -- Reviewer
  created_at timestamp without time zone NOT NULL,
  created_by varchar(40) NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar(40),
  CONSTRAINT rating_beer_id_fkey FOREIGN KEY (beer_id)
    REFERENCES beers (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT rating_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES users (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE reviews (
  id integer PRIMARY KEY,
  title varchar(40) NOT NULL,
  body text NOT NULL,
  beer_id integer NOT NULL,                   -- Beer to be reviewed
  user_id integer NOT NULL,                   -- Reviewer
  created_at timestamp without time zone NOT NULL,
  created_by varchar(40) NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar(40),
  CONSTRAINT review_beer_id_fkey FOREIGN KEY (beer_id)
    REFERENCES beers (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT review_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES users (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);
