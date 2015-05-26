yadda=# explain analyze select * from top_beers where breweryid=3;
 Subquery Scan on top_beers  (cost=3617.10..3617.21 rows=9 width=48) (actual time=0.783..0.785 rows=3 loops=1)
   ->  Sort  (cost=3617.10..3617.12 rows=9 width=48) (actual time=0.782..0.782 rows=3 loops=1)
         Sort Key: (count(ratings.overall))
         Sort Method: quicksort  Memory: 25kB
         ->  HashAggregate  (cost=3616.87..3616.96 rows=9 width=48) (actual time=0.776..0.777 rows=3 loops=1)
               ->  Nested Loop Left Join  (cost=5.76..3610.12 rows=900 width=48) (actual time=0.053..0.699 rows=316 loops=1)
                     ->  Nested Loop Left Join  (cost=0.56..221.78 rows=9 width=44) (actual time=0.025..0.218 rows=3 loops=1)
                           Join Filter: (beers.brewery_id = breweries.brewery_id)
                           ->  Index Scan using breweries_id_index on breweries  (cost=0.28..8.29 rows=1 width=22) (actual time=0.007..0.007 rows=1 loops=1)
                                 Index Cond: (brewery_id = 3)
                           ->  Index Scan using beers_id_to_breweries_id_index on beers  (cost=0.29..213.38 rows=9 width=26) (actual time=0.015..0.207 rows=3 loops=1)
                                 Index Cond: (brewery_id = 3)
                     ->  Bitmap Heap Scan on ratings  (cost=5.20..375.48 rows=100 width=8) (actual time=0.030..0.132 rows=105 loops=3)
                           Recheck Cond: (beer_id = beers.beer_id)
                           ->  Bitmap Index Scan on ratings_beer_id_index  (cost=0.00..5.17 rows=100 width=0) (actual time=0.018..0.018 rows=105 loops=3)
                                 Index Cond: (beer_id = beers.beer_id)
 Total runtime: 0.829 ms

yadda=# explain analyze select * from recent_score where breweryid=3;
 Subquery Scan on recent_score  (cost=3612.85..3612.96 rows=9 width=72) (actual time=0.814..0.817 rows=3 loops=1)
   ->  Sort  (cost=3612.85..3612.87 rows=9 width=48) (actual time=0.813..0.813 rows=3 loops=1)
         Sort Key: (avg(ratings.overall))
         Sort Method: quicksort  Memory: 25kB
         ->  GroupAggregate  (cost=5.74..3612.71 rows=9 width=48) (actual time=0.367..0.806 rows=3 loops=1)
               ->  Nested Loop  (cost=5.74..3610.50 rows=279 width=48) (actual time=0.055..0.728 rows=104 loops=1)
                     ->  Nested Loop  (cost=0.56..221.78 rows=9 width=44) (actual time=0.024..0.194 rows=3 loops=1)
                           ->  Index Scan using beers_id_to_breweries_id_index on beers  (cost=0.29..213.38 rows=9 width=26) (actual time=0.016..0.181 rows=3 loops=1)
                                 Index Cond: (brewery_id = 3)
                           ->  Materialize  (cost=0.28..8.30 rows=1 width=22) (actual time=0.003..0.003 rows=1 loops=3)
                                 ->  Index Scan using breweries_id_index on breweries  (cost=0.28..8.29 rows=1 width=22) (actual time=0.005..0.006 rows=1 loops=1)
                                       Index Cond: (brewery_id = 3)
                     ->  Bitmap Heap Scan on ratings  (cost=5.18..376.21 rows=31 width=8) (actual time=0.026..0.159 rows=35 loops=3)
                           Recheck Cond: (beer_id = beers.beer_id)
                           Filter: (created_at >= (now() - '6 mons'::interval))
                           Rows Removed by Filter: 71
                           ->  Bitmap Index Scan on ratings_beer_id_index  (cost=0.00..5.17 rows=100 width=0) (actual time=0.014..0.014 rows=105 loops=3)
                                 Index Cond: (beer_id = beers.beer_id)
 Total runtime: 0.863 ms

yadda=# explain analyze select * from also_enjoy where beerstyle='alarm';
 Subquery Scan on also_enjoy3  (cost=27591.36..27716.36 rows=10000 width=118) (actual time=50.804..50.876 rows=398 loops=1)
   ->  Sort  (cost=27591.36..27616.36 rows=10000 width=94) (actual time=50.803..50.829 rows=398 loops=1)
         Sort Key: (random())
         Sort Method: quicksort  Memory: 72kB
         ->  GroupAggregate  (cost=0.71..26412.47 rows=10000 width=94) (actual time=0.217..50.648 rows=398 loops=1)
               Filter: (avg(ratings.overall) > 4::numeric)
               Rows Removed by Filter: 9
               ->  Nested Loop Left Join  (cost=0.71..25812.47 rows=40000 width=94) (actual time=0.042..34.437 rows=40483 loops=1)
                     ->  Nested Loop  (cost=0.29..585.64 rows=400 width=90) (actual time=0.034..4.683 rows=407 loops=1)
                           Join Filter: (beers.style_id = styles.style_id)
                           Rows Removed by Join Filter: 9593
                           ->  Index Scan using beers_pkey on beers  (cost=0.29..434.32 rows=10000 width=26) (actual time=0.008..1.718 rows=10000 loops=1)
                           ->  Materialize  (cost=0.00..1.32 rows=1 width=72) (actual time=0.000..0.000 rows=1 loops=10000)
                                 ->  Seq Scan on styles  (cost=0.00..1.31 rows=1 width=72) (actual time=0.004..0.006 rows=1 loops=1)
                                       Filter: ((style)::text = 'alarm'::text)
                                       Rows Removed by Filter: 24
                     ->  Index Scan using ratings_beer_id_index on ratings  (cost=0.42..62.07 rows=100 width=8) (actual time=0.004..0.057 rows=99 loops=407)
                           Index Cond: (beer_id = beers.beer_id)
 Total runtime: 50.934 ms