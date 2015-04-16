-- Usage: psql -d yadda -f yadda/yadda-indices.sql

-- indices
CREATE UNIQUE INDEX breweries_id_index ON breweries(brewery_id);
CREATE INDEX beers_id_to_breweries_id_index ON beers(beer_id, brewery_id);
CREATE INDEX persons_id_index ON persons(person_id);
CREATE UNIQUE INDEX ratings_id_index ON ratings(rating_id);

-- multicolumn indices
CREATE INDEX persons_to_beers_index ON ratings(person_id, beer_id);

-- attempt at functional index
-- CREATE INDEX rating_avg_computed_idx ON rating (AVG(overall));