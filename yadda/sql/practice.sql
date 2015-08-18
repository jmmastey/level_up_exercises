INSERT INTO addresses (id, address_line_1, city, state, zipcode, country, created_by) VALUES
    (1, '175 West Jackson Boulevard', 'Chicago', 'IL', '60606', 'United States', 'shaan');

UPDATE addresses SET zipcode = '60604' WHERE id = 1;

DELETE FROM addresses where city = 'Chicago';

