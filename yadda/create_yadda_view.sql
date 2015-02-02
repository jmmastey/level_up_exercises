BEGIN;

CREATE OR REPLACE VIEW yadda.average_rating_view AS
  SELECT st.id,
         br.name,
         st.style,
    AVG((r.look+r.smell+r.taste+r.feel+r.overall)) rating
    FROM yadda.ratings r
    JOIN yadda.beers b on r.beer_id = b.id
    JOIN yadda.breweries br on b.brewery_id = br.id
    JOIN yadda.beer_styles st on b.style_id = st.id
  GROUP BY name, style, st.id
  ORDER BY name
;

CREATE OR REPLACE VIEW yadda.top_beer_from_brewery AS
 SELECT name,style,rating
  FROM (
    SELECT name,rating,style, rank() OVER(PARTITION BY name
      ORDER BY rating DESC) AS rank FROM  yadda.average_rating_view)ss
where rank=1;


CREATE OR REPLACE VIEW yadda.recent_average_rating_view AS
  SELECT st.id,
         br.name,
         st.style,
         AVG((r.look+r.smell+r.taste+r.feel+r.overall)) rating
    FROM yadda.ratings r
    JOIN yadda.beers b on r.beer_id = b.id
    JOIN yadda.breweries br on b.brewery_id = br.id
    JOIN yadda.beer_styles st on b.style_id = st.id
    WHERE r.created_on > CURRENT_DATE - INTERVAL '6 months'
    GROUP BY name, style, st.id
    ORDER BY name;


CREATE OR REPLACE FUNCTION yadda.you_might_also_enjoy(beer TEXT)
  RETURNS SETOF yadda.average_rating_view AS $$
    DECLARE
    sql text := 'SELECT * FROM
      (SELECT *
        FROM yadda.average_rating_view where style IN (
          SELECT st.style from yadda.beer_styles st
            JOIN yadda.beer_styles st1 ON st.category_id = st1.category_id
          AND st1.style =' || quote_literal($1) ||'
      ) AND style <> '|| quote_literal($1) ||' ORDER BY rating DESC LIMIT 3
  )tmp ORDER by random()';
    BEGIN
      RETURN QUERY EXECUTE sql
      USING beer;
    END;
$$ LANGUAGE plpgsql;
COMMIT;
