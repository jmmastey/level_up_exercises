-- Drop existing views
DROP VIEW IF EXISTS top_beers;
DROP VIEW IF EXISTS recent_score;
DROP VIEW IF EXISTS recommendations;

-- Top beers from a given brewery
CREATE VIEW top_beers AS
  SELECT breweries.name, beers.style, beers.description, beers.year
  FROM beers
  INNER JOIN breweries ON beers.brewery_id = breweries.id
  INNER JOIN ratings ON beers.id = ratings.beer_id
  GROUP BY beers.id, beers.style, beers.description, beers.year, breweries.id, breweries.name
  ORDER BY SUM(ratings.overall) DESC;

-- Recent score
CREATE VIEW recent_score AS
  SELECT AVG(overall) AS overall
  FROM ratings
  WHERE ratings.created_at > NOW() - interval '6 months';

-- You might also enjoy
CREATE VIEW recommendations AS
  SELECT beers.*
  FROM beers
  WHERE (
    SELECT AVG(ratings.overall) FROM ratings WHERE ratings.beer_id = beers.id
  ) > 4
  ORDER BY RANDOM()
  LIMIT 10;
