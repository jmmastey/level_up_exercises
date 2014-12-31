CREATE TABLE addresses (
  id integer PRIMARY KEY,
  address_line_1 varchar NOT NULL,
  address_line_2 varchar,
  city varchar NOT NULL,
  region varchar NOT NULL,
  postal_code varchar NOT NULL,
  country varchar NOT NULL,
  created_at timestamp without time zone NOT NULL,
  created_by varchar NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar
);

CREATE TABLE breweries (
  id integer PRIMARY KEY,
  name varchar NOT NULL,
  description text NOT NULL,
  address_id integer NOT NULL,
  created_at timestamp without time zone NOT NULL,
  created_by varchar NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar,
  CONSTRAINT brewery_address_id_fkey FOREIGN KEY (address_id)
    REFERENCES addresses (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE users (
  id integer PRIMARY KEY,
  username varchar NOT NULL UNIQUE,
  email varchar NOT NULL UNIQUE,
  encrypted_password varchar NOT NULL,
  reset_password_token varchar,
  reset_password_sent_at timestamp without time zone,
  active boolean NOT NULL,
  sign_in_count integer DEFAULT 0 NOT NULL,
  location varchar,
  created_at timestamp without time zone NOT NULL,
  created_by varchar NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar
);

CREATE TABLE beers (
  id integer PRIMARY KEY,
  style varchar NOT NULL,
  description text NOT NULL,
  year char(4) NOT NULL,
  brewery_id integer NOT NULL,
  created_at timestamp without time zone NOT NULL,
  created_by varchar NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar,
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
  beer_id integer NOT NULL,                                     -- Beer to be rated
  user_id integer NOT NULL,                                     -- Reviewer
  created_at timestamp without time zone NOT NULL,
  created_by varchar NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar,
  CONSTRAINT rating_beer_id_fkey FOREIGN KEY (beer_id)
    REFERENCES beers (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT rating_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES users (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE reviews (
  id integer PRIMARY KEY,
  title varchar NOT NULL,
  body text NOT NULL,
  beer_id integer NOT NULL,                                     -- Beer to be reviewed
  user_id integer NOT NULL,                                     -- Reviewer
  created_at timestamp without time zone NOT NULL,
  created_by varchar NOT NULL,
  updated_at timestamp without time zone,
  updated_by varchar,
  CONSTRAINT review_beer_id_fkey FOREIGN KEY (beer_id)
    REFERENCES beers (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT review_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES users (id) MATCH SIMPLE
    ON UPDATE CASCADE ON DELETE RESTRICT
);
