\connect yadda;
DELETE FROM breweries;
INSERT INTO breweries (name, street_address, city, country, zip_code, description, founding_year, modified_by, created_by)
  VALUES ('Left Hand', '321 Fake St.', 'City', 'Country', '54321', 'Good beer', '2000', 'Admin', 'Admin');

SELECT * FROM breweries;

UPDATE breweries SET city='NewCity', country='NewCountry' WHERE id=1;

SELECT * FROM breweries;

DELETE FROM breweries WHERE name='Left Hand';;

SELECT * FROM breweries;