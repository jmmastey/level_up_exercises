-- Top beers from a given brewery, according to their total ratings.
DROP VIEW IF EXISTS top_beers CASCADE;
CREATE VIEW top_beers AS
  SELECT
    b.id AS beer_id,
    b.name AS beer,
    br.name AS brewery,
    br.id AS brewery_id,
    b.beer_style_id AS beer_style_id,
    r.overall AS score
  FROM
    beers b
  INNER JOIN
    ratings r ON b.id = r.beer_id
  INNER JOIN
    breweries br ON br.id = b.brewery_id
  ORDER BY
    r.overall DESC;

-- "Recent score" for a beer, where only ratings within the last six months are counted and the ratings within that period are averaged.
DROP VIEW IF EXISTS recent_score_for_beer CASCADE;
CREATE VIEW recent_score_for_beer AS
  SELECT
    beer_id,
    round(AVG(ratings.overall), 2) AS average_score
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
    b.id AS beer_id,
    b.name AS beer_name,
    bs.name AS beer_style,
    br.name AS brewery,
    br.id AS brewery_id,
    round(AVG(r.overall), 2) AS average_score
  FROM
    beers b
  INNER JOIN
    beer_styles bs ON bs.id = b.beer_style_id
  INNER JOIN
    ratings r ON r.beer_id = b.id
  INNER JOIN
    breweries br ON br.id = b.brewery_id
  GROUP BY
    b.id, b.name, bs.name, br.name, br.id
  HAVING
    AVG(r.overall) > 4.0
  ORDER BY
    RANDOM();
