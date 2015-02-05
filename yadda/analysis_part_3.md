**Analysis of Query 1:** The trouble spots are the Sequential Scan on ratings and the Inner Join between ratings and beers.

1. Place an index on ratings.id. This will change the Sequential Scan on ratings to an Index scan.
2. Place a multicolumn index on ratings.beer_id and beers.id. This will improve the efficiency of the Inner Join.

**Analysis of Query 2:** The trouble spots are the Sequential Scan on ratings, the Inner Join between ratings and beers, and possibly, the ratings.created_at column that is involved in the WHERE clause.

The indices recommended in Query 1 above will help the first two trouble spots in Query 2. In addition, I would consider putting an index on ratings.created_at.

**Analysis of Query 3:** The trouble spots are the Sequential Scan on ratings, the Inner Join between ratings and beers, the Group by between beer_styles_lookup.name and beers.name and the filter with the average ratings.

The indices recommended in Query 1 above will help the first two trouble spots in Query 3. In addition, I would consider doing the following:

1. Placing a multicolumn index on beer_styles_lookup.name and beers.name
2. Placing indices on ratings.look, ratings.smell, ratings.taste, and ratings.feel, which are involved in a HAVING clause calculating an average.
