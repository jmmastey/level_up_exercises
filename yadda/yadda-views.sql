-- Usage: psql -d yadda -f yadda/yadda-views.sql

-- Top beers from a given brewery, according to their total ratings. 
CREATE OR REPLACE VIEW top_beers AS
  SELECT breweries.brewery_id AS breweryid,
    breweries.name AS breweryname,
    beers.name AS beername,
    COUNT(ratings.overall) AS ratings_count
  FROM breweries 
  LEFT JOIN beers ON beers.brewery_id = breweries.brewery_id
  LEFT JOIN ratings ON ratings.beer_id = beers.beer_id
  GROUP BY breweries.brewery_id, beers.beer_id
  ORDER BY ratings_count DESC;

-- "Recent score" for a beer, where only ratings within the last six months are counted and the ratings within that period are averaged. 
CREATE OR REPLACE VIEW recent_score AS
  SELECT breweries.brewery_id AS breweryid,
    breweries.name AS breweryname,
    beers.name AS beername,
    AVG(ratings.overall) AS average_rating
  FROM breweries 
  LEFT JOIN beers ON beers.brewery_id = breweries.brewery_id 
  LEFT JOIN ratings ON ratings.beer_id = beers.beer_id
  WHERE ratings.created_at >= (NOW() - interval '6 months')
  GROUP BY breweries.brewery_id, beers.beer_id
  ORDER BY average_rating DESC;

-- "You might also enjoy", which picks beers of the same style with high average scores, and then sorts them randomly. 
CREATE OR REPLACE VIEW also_enjoy AS
  SELECT beers.name AS beername,
    styles.style AS beerstyle,
    AVG(ratings.overall) AS average_rating
  FROM beers
  LEFT JOIN ratings ON ratings.beer_id = beers.beer_id
  LEFT JOIN styles ON beers.style_id = styles.style_id
  GROUP BY styles.style, beers.beer_id
  HAVING AVG(ratings.overall) > 4
  ORDER BY RANDOM();
