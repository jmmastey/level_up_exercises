-- yadda.sql -- for PostgreSQL
-- Prepared by Paul Haddad

-- Create schema
CREATE SCHEMA yadda;


-- User Table
DROP TABLE IF EXISTS yadda.users CASCADE;
CREATE TABLE yadda.users (
  id            serial PRIMARY KEY,
  username      varchar(50) UNIQUE NOT NULL,
  password      varchar(50) NOT NULL,
  first_name    text NOT NULL,
  last_name     text NOT NULL,
  address       text NOT NULL,
  city          text NOT NULL,
  state         char(2) NOT NULL,
  zip_code      varchar(20) NOT NULL,
  phone_number  varchar(30) NULL,
  email         varchar(500) NOT NULL,
  active        boolean DEFAULT true,
  created_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Brewery Table
DROP TABLE IF EXISTS yadda.breweries CASCADE;
CREATE TABLE yadda.breweries (
  id            serial PRIMARY KEY,
  name          text NOT NULL,
  address       text NOT NULL,
  city          text NOT NULL,
  state         varchar(2) NOT NULL,
  zip_code      varchar(5) NOT NULL,
  description   text,
  founding_year char(4),
  created_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by    int REFERENCES yadda.users ON DELETE RESTRICT, -- one-to many relationship between user and breweries; disallow deletion of user if it still references a brewery
  updated_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by    int REFERENCES yadda.users ON DELETE RESTRICT -- one-to many relationship between user and breweries; disallow deletion of user if it still references a brewery
);


-- Beer Styles Lookup Table
DROP TABLE IF EXISTS yadda.beer_styles_lookup CASCADE;
CREATE TABLE yadda.beer_styles_lookup (
  id            serial PRIMARY KEY,
  name          text
);


-- Beer Table
DROP TABLE IF EXISTS yadda.beers CASCADE;
CREATE TABLE yadda.beers (
  id            serial PRIMARY KEY,
  name          text NOT NULL,
  style_id      int REFERENCES yadda.beer_styles_lookup ON DELETE RESTRICT,
  description   text,
  brewing_year  date,
  created_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by    int REFERENCES yadda.users ON DELETE RESTRICT, -- one-to many relationship between user and beer; disallow deletion of user if it still references a beer
  updated_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by    int REFERENCES yadda.users ON DELETE RESTRICT, -- one-to many relationship between user and beer; disallow deletion of user if it still references a beer
  brewery_id    int REFERENCES yadda.breweries ON DELETE CASCADE -- one-to-many relationship between brewery and beers; delete all associated beers if a brewery is deleted
);


-- Rating Table
DROP TABLE IF EXISTS yadda.ratings CASCADE;
CREATE TABLE yadda.ratings (
  id            serial PRIMARY KEY,
  look          int CHECK (look BETWEEN 0 AND 5) DEFAULT 0,
  smell         int CHECK (smell BETWEEN 0 AND 5) DEFAULT 0,
  taste         int CHECK (taste BETWEEN 0 AND 5) DEFAULT 0,
  feel          int CHECK (feel BETWEEN 0 AND 5) DEFAULT 0,
  overall       int CHECK (overall BETWEEN 0 AND 5) DEFAULT 0,
  created_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, -- no created_by or updated_by fields because this must be the associated user by definition
  updated_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id       int REFERENCES yadda.users ON DELETE RESTRICT, -- one-to many relationship between user and ratings; disallow deletion of user if it still references a rating
  beer_id       int REFERENCES yadda.beers ON DELETE RESTRICT -- one-to many relationship between beer and ratings; disallow deletion of beer if it still references a rating
);
