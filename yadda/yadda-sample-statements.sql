/* User sample statements */
INSERT INTO person (name, email, birthday, updated_by) 
  VALUES('Ryan', 'rcowan@enova.com', '1984-01-30', 1);

UPDATE person SET description='Ryan works at Enova' WHERE person_id=1;

/* Brewery sample statements */
INSERT INTO brewery (name, address, city, state, postal_code, description, founding_year, updated_at, updated_by) 
  VALUES('Revolution', '123 Main St', 'Chicago', 'IL', '60618', 'A brewery', '1980', NOW(), 1);

UPDATE brewery SET name='Revolution Brewery', address='543 Opposite Ave' WHERE brewery_id=1;

/* Beer sample statements */
INSERT INTO beer (brewery_id, style, name, description, brewing_year, updated_at, updated_by)
  VALUES(1, 'Stout', 'Some Beer', 'Rich and filling', '2014', NOW(), 1);

UPDATE beer SET style='Porter', brewing_year='2013' WHERE beer_id=1;

/* Rating sample statements */
INSERT INTO rating (person_id, beer_id, look, smell, taste, feel, overall, description, updated_by) 
  VALUES(1, 1, 5, 4, 3, 4, 5, 'A meal in a glass', 1);

UPDATE rating SET look=3, taste=5, overall=4 WHERE rating_id=1;

/* Clean up */
DELETE FROM rating WHERE rating_id=1;
DELETE FROM beer WHERE beer_id=1;
DELETE FROM brewery WHERE brewery_id=1;
DELETE FROM person WHERE person_id=1;
