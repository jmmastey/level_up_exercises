## Troubleshooting Performance with ![Explain](https://31.media.tumblr.com/tumblr_mdjf2gVItN1qih9gi.gif)

#### Recent Score Output:

```
 HashAggregate  (cost=4921.92..5046.04 rows=9929 width=6)

   Group Key: ratings.beer_id

   ->  Seq Scan on ratings  (cost=0.00..4172.00 rows=149985 width=6)

         Filter: (created_at > (now() - '6 mons'::interval))
```

#### Recommendations Output:

```
 Subquery Scan on recommendations  (cost=34237214.02..34237255.68 rows=3333 width=65)

   ->  Sort  (cost=34237214.02..34237222.35 rows=3333 width=65)

         Sort Key: (random())

         ->  HashAggregate  (cost=34236977.33..34237018.99 rows=3333 width=65)

               Group Key: beers.id, beers.style, beers.description, beers.year

               ->  Seq Scan on beers  (cost=0.00..34236944.00 rows=3333 width=65)

                     Filter: ((SubPlan 1) > 4::numeric)

                     SubPlan 1

                       ->  Aggregate  (cost=3422.04..3422.05 rows=1 width=2)

                             ->  Seq Scan on ratings  (cost=0.00..3422.00 rows=15 width=2)

                                   Filter: (beer_id = beers.id)
```

#### Top Beers:

```
 Subquery Scan on top_beers  (cost=20061.88..20062.13 rows=20 width=69)

   ->  Sort  (cost=20061.88..20061.93 rows=20 width=71)

         Sort Key: (sum(ratings.overall))

         ->  HashAggregate  (cost=20061.25..20061.45 rows=20 width=71)

               Group Key: beers.id, beers.style, beers.description, beers.year, beers.brewery_id

               ->  Hash Join  (cost=16444.25..20056.75 rows=300 width=71)

                     Hash Cond: (ratings.beer_id = beers.id)

                     ->  Seq Scan on ratings  (cost=0.00..3047.00 rows=150000 width=6)

                     ->  Hash  (cost=16444.00..16444.00 rows=20 width=69)

                           ->  Seq Scan on beers  (cost=0.00..16444.00 rows=20 width=69)

                                 Filter: (brewery_id = 1)
```

### Explanation

The Recent Score view does a sequential scan comparing the created_at field,
resulting in a larger cost than needed.

The Recommendations view has a huge cost, as it performs a sequential scan on
ratings (matching the ratings to the beers).  This first operation has a high
cost.  It then computes the average overall scores of those beers and runs a
sequential scan against those results, comparing the average overall score to
the minimum requirement for the view (4).  This operation has a massive cost.
The view then selects the fields it needs for the view and randomly sorts the
results.

Finally, the Top Beers view has a medium cost that can be reduced.  First, it
runs a sequential scan against the brewery ID it is searching against.  We then
match these filtered beers to their ratings, which has a medium-sized cost.
After selecting only the fields we need, we sum the joined ratings and sort by
the result (almost no cost).

### Improvements

I would start improving this query by adding indicies to all the foreign keys,
especially `beers.brewery_id` and `ratings.beer_id`.  I would also add an index
to `ratings.created_by`, as we are filtering that field when retrieving the
recent score for a beer.
