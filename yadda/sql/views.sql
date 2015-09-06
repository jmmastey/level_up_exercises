\connect yadda

-- Top beers.
CREATE OR REPLACE VIEW top_beers AS
  SELECT
    breweries.id AS brewery_id,
    breweries.name AS brewery_name,
    beers.name AS beer_name,
    COUNT(ratings.overall) AS rating_count
  FROM breweries
  LEFT JOIN beers ON beers.brewery_id = breweries.id
  LEFT JOIN ratings ON ratings.beer_id = beers.id
  GROUP BY breweries.id, beers.id
  ORDER BY rating_count DESC;

-- Recent Score
CREATE OR REPLACE VIEW recent_score AS
  SELECT
    breweries.id AS brewery_id,
    breweries.name AS brewery_name,
    beers.name AS beer_name,
    AVG(ratings.overall) AS average_rating
  FROM breweries
  LEFT JOIN beers ON beers.brewery_id = breweries.id
  LEFT JOIN ratings ON ratings.beer_id = beers.id
  WHERE ratings.created_on >= (NOW() - interval '6 months')
  GROUP BY breweries.id, beers.id
  ORDER BY rating_count DESC;

-- Might also enjoy
CREATE OR REPLACE VIEW might_also_enjoy AS
  SELECT
    beers.name AS beer_name,
    styles.style AS beer_style,
    AVG(ratings.overall) AS average_rating
  FROM beers
  LEFT JOIN ratings ON ratings.beer_id = beers.id
  LEFT JOIN styles ON beers.style_id = styles.id
  GROUP BY styles.style, beers.id
  HAVING AVG(ratings.overall) > 7
  ORDER BY RANDOM();
