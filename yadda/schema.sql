DROP DATABASE IF EXISTS yadda;
CREATE DATABASE yadda;
\connect yadda

CREATE TABLE users (
  user_id         SERIAL PRIMARY KEY,
  username        VARCHAR(50) NOT NULL,
  password_digest VARCHAR(50) NOT NULL,
  name            VARCHAR(255) NOT NULL,
  email           VARCHAR(255) NOT NULL,
  created_at      TIMESTAMP DEFAULT NOW(),
  created_by      INTEGER NOT NULL REFERENCES users,
  updated_at      TIMESTAMP DEFAULT NOW(),
  updated_by      INTEGER NOT NULL REFERENCES users
);
COMMENT ON TABLE users IS 'User data.';

CREATE TABLE breweries (
  brewery_id     SERIAL PRIMARY KEY,
  name           VARCHAR(255) NOT NULL,
  street_address VARCHAR(100),
  city           VARCHAR(100) NOT NULL,
  state_code     VARCHAR(2) NOT NULL,
  zip            VARCHAR(10),
  description    TEXT,
  founding_year  VARCHAR(4),
  created_at     TIMESTAMP DEFAULT NOW(),
  created_by     INTEGER NOT NULL REFERENCES users,
  updated_at     TIMESTAMP DEFAULT NOW(),
  updated_by     INTEGER NOT NULL REFERENCES users
);
COMMENT ON TABLE breweries IS 'Brewery data.';

CREATE TABLE beers (
  beer_id      SERIAL PRIMARY KEY,
  name         VARCHAR(255) NOT NULL,
  style        VARCHAR(50),
  description  TEXT,
  brewery_id   INTEGER NOT NULL REFERENCES breweries ON DELETE CASCADE,
  brewing_year VARCHAR(4) NOT NULL,
  created_at   TIMESTAMP DEFAULT NOW(),
  created_by   INTEGER NOT NULL REFERENCES users,
  updated_at   TIMESTAMP DEFAULT NOW(),
  updated_by   INTEGER NOT NULL REFERENCES users
);
COMMENT ON TABLE beers IS 'Beer data.';

CREATE TABLE ratings (
  rating_id  SERIAL PRIMARY KEY,
  user_Id    INTEGER NOT NULL REFERENCES users ON DELETE CASCADE,
  beer_id    INTEGER NOT NULL REFERENCES beers ON DELETE CASCADE,
  look       FLOAT(3),
  smell      FLOAT(3),
  taste      FLOAT(3),
  feel       FLOAT(3),
  overall    FLOAT(3) NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  created_by INTEGER NOT NULL REFERENCES users,
  updated_at TIMESTAMP DEFAULT NOW(),
  updated_by INTEGER NOT NULL REFERENCES users
);
COMMENT ON TABLE users IS 'Beer ratings made by users.';
