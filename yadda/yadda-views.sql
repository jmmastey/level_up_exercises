/* Top beers from a given brewery, according to their total ratings. */

create or replace view top_beers AS
  select brewery.name as breweryname,
    beer.name as beername,
    ratings.ratings_count
  from brewery 
    left join beer on beer.brewery_id = brewery.brewery_id 
    left join (select beer_id,
                 COUNT(rating.overall) as ratings_count 
               from rating 
               group by beer_id) ratings on ratings.beer_id=beer.beer_id
  where brewery.brewery_id=1
  order by ratings_count desc;

/* "Recent score" for a beer, where only ratings within the last six months are counted and the ratings within that period are averaged. */
create or replace view recent_score AS
  select brewery.name as breweryname,
    beer.name as beername,
    ratings.computed
  from brewery 
    left join beer on beer.brewery_id = brewery.brewery_id 
    left join (select beer_id,
                 COUNT(rating.overall) as computed 
               from rating 
               where 
               group by beer_id) ratings on ratings.beer_id=beer.beer_id
  where brewery.brewery_id=1
  order by computed desc;
