DROP VIEW IF EXISTS beer_scores CASCADE;

CREATE VIEW beer_scores AS
  SELECT
    beer_id,
    created_on,
    ((appearance + aroma + taste + texture + overall) * 2) AS score
  FROM
    ratings;

DROP VIEW IF EXISTS beers_with_scores CASCADE;

CREATE VIEW beers_with_scores AS
  SELECT
    b.*,
    ROUND(AVG(bs.score)) AS score
  FROM
    beers AS b,
    beer_scores AS bs
  WHERE
    b.id = bs.beer_id
  GROUP BY
    b.id;

DROP VIEW IF EXISTS top_beers CASCADE;

CREATE VIEW top_beers AS
  SELECT
    *
  FROM
    beers_with_scores
  ORDER BY
    score DESC;

-- SELECT * FROM top_beers WHERE brewery_id = N;

DROP VIEW IF EXISTS beers_with_recent_scores CASCADE;

CREATE VIEW beers_with_recent_scores AS
  SELECT
    b.*,
    ROUND(AVG(bs.score)) AS score
  FROM
    beers AS b,
    beer_scores AS bs
  WHERE
    b.id = bs.beer_id AND
    bs.created_on > 'NOW'::TIMESTAMP - '1 MONTH'::INTERVAL
  GROUP BY
    b.id;

-- SELECT * FROM beers_with_recent_scores WHERE id = N;

DROP VIEW IF EXISTS recommended_beers CASCADE;

CREATE VIEW recommended_beers AS
  SELECT
    b.*
  FROM
    beers AS b
  WHERE
    b.id IN (SELECT tb.id FROM top_beers AS tb
             WHERE tb.beer_style_id = b.beer_style_id LIMIT 3)
  ORDER BY
    RANDOM();

-- SELECT * FROM recommended_beers WHERE beer_style_id = N;
