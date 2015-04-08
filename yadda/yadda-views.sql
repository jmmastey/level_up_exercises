-- Usage: psql -d yadda -f yadda/yadda-views.sql

#try to keep inner joins
#preferable over subqueries

-- Top beers from a given brewery, according to their total ratings. 
create or replace view top_beers AS
  select breweries.brewery_id as breweryid,
    breweries.name as breweryname,
    beers.name as beername,
    ratings.ratings_count
  from breweries 
  left join beers on beers.brewery_id = breweries.brewery_id 
  left join (select beer_id,
               COUNT(rating.overall) as ratings_count 
             from ratings 
             group by beer_id) ratings on ratings.beer_id = beers.beer_id
  order by ratings_count desc;

-- "Recent score" for a beer, where only ratings within the last six months are counted and the ratings within that period are averaged. 
create or replace view recent_score AS
  select breweries.brewery_id as breweryid,
    breweries.name as breweryname,
    beers.name as beername,
    ratings.computed
  from breweries 
  inner join beers on beers.brewery_id = breweries.brewery_id 
  left join (select beer_id,
               AVG(ratings.overall) as computed 
             from ratings 
             where created_at >= (NOW() - interval '6 months')
             group by beer_id) ratings on ratings.beer_id = beers.beer_id
  order by computed desc;

-- "You might also enjoy", which picks beers of the same style with high average scores, and then sorts them randomly. 
create or replace view also_enjoy AS
  select beers.name as beername,
    styles.style as beerstyle,
    ratings.computed
  from beers
  inner join styles on beers.style_id = styles.style_id
  inner join (select beer_id,
               AVG(ratings.overall) as computed 
             from ratings 
             group by beer_id) ratings on ratings.beer_id = beers.beer_id
  order by RANDOM();
