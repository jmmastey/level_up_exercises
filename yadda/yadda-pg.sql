-- sql -- for PostgreSQL
-- Prepared by Paul Haddad
-- For Level Up 6 - Yadda

-- Users Table
DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
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
  created_by    varchar(50) NOT NULL,
  created_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by    varchar(50)
);


-- Breweries Table
DROP TABLE IF EXISTS breweries CASCADE;
CREATE TABLE breweries (
  id            serial PRIMARY KEY,
  name          text NOT NULL,
  address       text NOT NULL,
  city          text NOT NULL,
  state         varchar(2) NOT NULL,
  zip_code      varchar(20) NOT NULL,
  description   text,
  founding_year char(4),
  created_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by    int REFERENCES users ON DELETE RESTRICT, -- one-to many relationship between user and breweries; disallow deletion of user if it still references a brewery
  updated_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by    int REFERENCES users ON DELETE RESTRICT -- one-to many relationship between user and breweries; disallow deletion of user if it still references a brewery
);


-- Beer Styles Lookup Table
DROP TABLE IF EXISTS beer_styles_lookup CASCADE;
CREATE TABLE beer_styles_lookup (
  id            serial PRIMARY KEY,
  name          text
);


-- Beers Table
DROP TABLE IF EXISTS beers CASCADE;
CREATE TABLE beers (
  id            serial PRIMARY KEY,
  name          text NOT NULL,
  style_id      int REFERENCES beer_styles_lookup ON DELETE RESTRICT,
  description   text,
  brewing_year  char(4),
  created_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by    int REFERENCES users ON DELETE RESTRICT, -- one-to many relationship between user and beer; disallow deletion of user if it still references a beer
  updated_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_by    int REFERENCES users ON DELETE RESTRICT, -- one-to many relationship between user and beer; disallow deletion of user if it still references a beer
  brewery_id    int REFERENCES breweries ON DELETE CASCADE -- one-to-many relationship between brewery and beers; delete all associated beers if a brewery is deleted
);


-- Ratings Table
DROP TABLE IF EXISTS ratings CASCADE;
CREATE TABLE ratings (
  id            serial PRIMARY KEY,
  look          int CHECK (look BETWEEN 0 AND 5) DEFAULT 0,
  smell         int CHECK (smell BETWEEN 0 AND 5) DEFAULT 0,
  taste         int CHECK (taste BETWEEN 0 AND 5) DEFAULT 0,
  feel          int CHECK (feel BETWEEN 0 AND 5) DEFAULT 0,
  created_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP, -- no created_by or updated_by fields because this must be the associated user by definition
  updated_at    timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id       int REFERENCES users ON DELETE RESTRICT, -- one-to many relationship between user and ratings; disallow deletion of user if it still references a rating
  beer_id       int REFERENCES beers ON DELETE RESTRICT -- one-to many relationship between beer and ratings; disallow deletion of beer if it still references a rating
);

-- Create Views for Part 2 of Yadda

-- Top beers from a given brewery, according to their total ratings.
-- Example Usage: SELECT * FROM top_beers_for_brewery WHERE brewery_name = 'Great Lakes' LIMIT 3;

CREATE VIEW top_beers_for_brewery AS
  SELECT breweries.name AS "brewery_name", beers.name AS "Beer Name",
   COUNT(ratings.id) AS "Total Ratings"
  FROM beers
  INNER JOIN ratings ON beers.id = ratings.beer_id
  INNER JOIN breweries ON beers.brewery_id = breweries.id
  GROUP BY breweries.name, beers.name
  ORDER BY "Total Ratings" DESC;

-- "Recent score" for a beer, where only ratings within the last six months are counted and the ratings within that period are averaged.
-- Example Usage: SELECT * from recent_score WHERE beer_name = 'Goose Island-Beer A';

CREATE VIEW recent_score AS
  SELECT beers.id, beers.name AS "beer_name", AVG((ratings.look + ratings.smell + ratings.taste + ratings.feel) / 4)
    AS "Rating"
  FROM beers
  INNER JOIN ratings ON beers.id = ratings.beer_id
  WHERE ratings.created_at > (CURRENT_TIMESTAMP - INTERVAL '6 months')
  GROUP BY beers.id;

-- "You might also enjoy", which picks beers of the same style with high average scores, and then sorts them randomly.
-- Example Usage: SELECT * FROM you_may_enjoy WHERE beer_style = 'Pale Ale' LIMIT 3;

CREATE VIEW you_may_enjoy AS
  SELECT beer_styles_lookup.id, beer_styles_lookup.name AS "beer_style", beers.name AS "Beer Name",
    AVG(((ratings.look + ratings.smell + ratings.taste + ratings.feel) / 4))
    AS "Overall Rating"
  FROM beers
  INNER JOIN beer_styles_lookup on beers.style_id = beer_styles_lookup.id
  INNER JOIN ratings on beers.id = ratings.beer_id
  GROUP BY beer_styles_lookup.id, beer_styles_lookup.name, beers.name
  HAVING AVG(((ratings.look + ratings.smell + ratings.taste + ratings.feel) / 4)) > 2.5
  ORDER BY RANDOM();


-- Create Views for Part 4 of Yadda

-- Index for beers.name
CREATE INDEX beers_name_index ON beers (name);

-- Index for overall ratings expression
CREATE INDEX beers_brewery_id_index ON beers (brewery_id);

-- Index for beer_styles_lookup.name
CREATE INDEX beer_styles_lookup_name_index ON beer_styles_lookup (name);

-- Index for ratings.created_at
CREATE INDEX ratings_created_at_index ON ratings (created_at);

-- Index for ratings.beer_id
CREATE INDEX ratings_beer_id_index ON ratings (beer_id);

-- Index for overall ratings expression
CREATE INDEX overall_ratings_index ON ratings (((look + smell + taste + feel) / 4));
