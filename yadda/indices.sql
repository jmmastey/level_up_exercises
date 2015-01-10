CREATE INDEX beers_brewery_id_idx ON beers (brewery_id ASC);
CREATE INDEX ratings_beer_id_idx ON ratings (beer_id ASC);
CREATE INDEX ratings_created_at_idx ON ratings (created_at DESC);
