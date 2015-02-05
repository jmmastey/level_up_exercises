/* Top beers from a given brewery, according to their total ratings. */
create or replace view topbeers AS
  select brewery.name as breweryname,
    beer.name as beername,
    ratings.computed
  from brewery 
    left join beer on beer.brewery_id = brewery.brewery_id 
    left join (select beer_id,
                 AVG(rating.overall) as computed 
               from rating 
               group by beer_id) ratings on ratings.beer_id=beer.beer_id
  where brewery.brewery_id=1
  order by computed desc
  limit 10;
  