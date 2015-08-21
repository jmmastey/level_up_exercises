-- Top beers from a given brewery, according to their total ratings.
DROP VIEW IF EXISTS top_beers CASCADE;
CREATE VIEW top_beers AS
  SELECT
    beers.name AS beer,
    beers.brewery_id AS brewery_id,
    beers.beer_style_id AS beer_style_id,
    ratings.overall AS score
  FROM
    beers
  INNER JOIN
    ratings ON beers.id = ratings.beer_id
  ORDER BY
    ratings.overall DESC;

-- "Recent score" for a beer, where only ratings within the last six months are counted and the ratings within that period are averaged.
DROP VIEW IF EXISTS recent_score_for_beer CASCADE;
CREATE VIEW recent_score_for_beer AS
  SELECT
    beer_id,
    round(AVG(ratings.overall), 2) AS score
  FROM
    ratings
  WHERE
    ratings.created_on > current_date - INTERVAL '6 months'
  GROUP BY
    beer_id;

-- "You might also enjoy", which picks beers of the same style with high average scores, and then sorts them randomly.
DROP VIEW IF EXISTS recommended_beers CASCADE;
CREATE VIEW recommended_beers AS
  SELECT
    beers.id AS beer_id,
    beers.name AS beer_name,
    beer_styles.name AS beer_style,
    round(AVG(ratings.overall), 2) AS score
  FROM
    beers
  INNER JOIN
    beer_styles ON beer_styles.id = beers.beer_style_id
  INNER JOIN
    ratings ON ratings.beer_id = beers.id
  GROUP BY
    beers.id, beers.name, beer_styles.name
  HAVING
    AVG(ratings.overall) > 4.0
  ORDER BY
    RANDOM();
