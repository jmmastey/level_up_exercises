CREATE UNIQUE INDEX brewery_id_index ON brewery(brewery_id);
CREATE UNIQUE INDEX beer_id_to_brewery_id_index ON beer(beer_id, brewery_id);
CREATE UNIQUE INDEX person_id_index ON person(person_id);
CREATE UNIQUE INDEX rating_id_index ON rating(rating_id);
CREATE UNIQUE INDEX person_to_beer_index ON rating(person_id, beer_id);
