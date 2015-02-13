-- Usage: psql -d postgres -f yadda/yadda-indices.sql

-- indices
CREATE UNIQUE INDEX brewery_id_index ON brewery(brewery_id);
CREATE INDEX beer_id_to_brewery_id_index ON beer(beer_id, brewery_id);
CREATE INDEX person_id_index ON person(person_id);
CREATE UNIQUE INDEX rating_id_index ON rating(rating_id);

-- multicolumn indices
CREATE INDEX person_to_beer_index ON rating(person_id, beer_id);

-- attempt at functional index
-- CREATE INDEX rating_avg_computed_idx ON rating (AVG(overall));