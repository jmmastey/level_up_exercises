I created the folliowing indices after the analysis from Part 3:

1. beers.name
2. beers.brewery_id
3. beer_styles_lookup.name
4. ratings.created_at
5. ratings.beer_id
6. overall_ratings ((ratings.look + ratings.smell + ratings.taste + ratings.feel) / 4)

As you can see below, the performance of each query improved considerably, especially the second and third.

**Analysis of Query 1 after changes:**

Previous EXPLAIN ANALYZE results:

Planning time: 0.281 ms
Execution time: 253.591 ms

Current EXPLAIN ANALYZE results:

Planning time: 0.372 ms
Execution time: 151.241 ms

**Analysis of Query 2 after changes:**

Previous EXPLAIN ANALYZE results:

Planning time: 0.277 ms
Execution time: 397.314 ms

Current EXPLAIN ANALYZE results:

Planning time: 0.189 ms
Execution time: 22.817 ms

**Analysis of Query 3 after changes:**

Previous EXPLAIN ANALYZE results:

Planning time: 0.221 ms
Execution time: 283.576 ms

Current EXPLAIN ANALYZE results:

Planning time: 0.387 ms
Execution time: 126.367 ms
