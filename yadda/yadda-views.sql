-- Usage: psql -d yadda -f yadda/yadda-views.sql

-- Top beers from a given brewery, according to their total ratings. 
create or replace view top_beers AS
  select breweries.brewery_id as breweryid,
    breweries.name as breweryname,
    beers.name as beername,
    COUNT(ratings.overall) as ratings_count
  from breweries 
  left join beers on beers.brewery_id = breweries.brewery_id
  left join ratings on ratings.beer_id = beers.beer_id
  group by breweries.brewery_id, beers.beer_id
  order by ratings_count desc;

-- "Recent score" for a beer, where only ratings within the last six months are counted and the ratings within that period are averaged. 
create or replace view recent_score AS
  select breweries.brewery_id as breweryid,
    breweries.name as breweryname,
    beers.name as beername,
    AVG(ratings.overall) as computed
  from breweries 
  left join beers on beers.brewery_id = breweries.brewery_id 
  left join ratings on ratings.beer_id = beers.beer_id
  where ratings.created_at >= (NOW() - interval '6 months')
  group by breweries.brewery_id, beers.beer_id
  order by computed desc;

-- "You might also enjoy", which picks beers of the same style with high average scores, and then sorts them randomly. 
create or replace view also_enjoy AS
  select beers.name as beername,
    styles.style as beerstyle,
    AVG(ratings.overall) as computed
  from beers
  left join styles on beers.style_id = styles.style_id
  left join ratings on ratings.beer_id = beers.beer_id
  group by styles.style_id, beers.beer_id
  order by RANDOM();
