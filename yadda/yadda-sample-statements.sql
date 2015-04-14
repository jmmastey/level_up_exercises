/* User sample statements */
INSERT INTO persons (name, email, birthday, created_at, updated_by) 
  VALUES('Ryan', 'rcowan@enova.com', '1984-01-30', NOW(), 1);

UPDATE persons SET description='Ryan works at Enova' WHERE person_id=1;

/* Brewery sample statements */
INSERT INTO breweries (name, address, city, state, postal_code, description, founding_year, created_at, updated_at, updated_by) 
  VALUES('Revolution', '123 Main St', 'Chicago', 'IL', '60618', 'A brewery', '1980', NOW(), NOW(), 1);

UPDATE breweries SET name='Revolution Brewery', address='543 Opposite Ave' WHERE brewery_id=1;

/* Beer sample statements */
INSERT INTO beers (brewery_id, style, name, description, brewing_year, created_at, updated_at, updated_by)
  VALUES(1, 'Stout', 'Some Beer', 'Rich and filling', '2014', NOW(), NOW(), 1);

UPDATE beers SET style='Porter', brewing_year='2013' WHERE beer_id=1;

/* Rating sample statements */
INSERT INTO ratings (person_id, beer_id, look, smell, taste, feel, overall, description, created_at, updated_by) 
  VALUES(1, 1, 5, 4, 3, 4, 5, 'A meal in a glass', NOW(), 1);

UPDATE ratings SET look=3, taste=5, overall=4 WHERE rating_id=1;

/* Clean up */
DELETE FROM ratings WHERE rating_id=1;
DELETE FROM beers WHERE beer_id=1;
DELETE FROM breweries WHERE brewery_id=1;
DELETE FROM persons WHERE person_id=1;
