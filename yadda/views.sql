-- Drop existing views
DROP VIEW IF EXISTS top_beers;
DROP VIEW IF EXISTS recent_score;
DROP VIEW IF EXISTS recommendations;

-- Top beers from a given brewery
CREATE VIEW top_beers AS
  SELECT
    beers.id,
    beers.style,
    beers.description,
    beers.year,
    beers.brewery_id
  FROM beers
  INNER JOIN ratings ON beers.id = ratings.beer_id
  GROUP BY
    beers.id,
    beers.style,
    beers.description,
    beers.year,
    beers.brewery_id
  ORDER BY SUM(ratings.overall) DESC;

-- Recent score
CREATE VIEW recent_score AS
  SELECT
    beer_id,
    AVG(overall) AS overall_rating
  FROM ratings
  WHERE created_at > NOW() - interval '6 months'
  GROUP BY beer_id;

-- You might also enjoy
CREATE VIEW recommendations AS
  SELECT
    beers.id,
    beers.style,
    beers.description,
    beers.year
  FROM beers
  WHERE (SELECT AVG(ratings.overall) FROM ratings WHERE ratings.beer_id = beers.id) > 4
  GROUP BY
    beers.id,
    beers.style,
    beers.description,
    beers.year
  ORDER BY RANDOM();
