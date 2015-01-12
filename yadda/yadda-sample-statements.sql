/* Brewery sample statements */
INSERT INTO brewery (name, address, city, state, zip_code, description, founding_year, modified_on, modified_by) 
  VALUES('Revolution', '123 Main St', 'Chicago', 'IL', '60618', 'A brewery', '1980', NOW(), 1);

UPDATE brewery SET name='Revolution Brewery', address='543 Opposite Ave' WHERE brewery_id=1 LIMIT 1;

DELETE FROM brewery WHERE brewery_id=1 LIMIT 1;
