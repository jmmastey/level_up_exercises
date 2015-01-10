INSERT INTO addresses (id, address_line_1, address_line_2, city, region, postal_code, country, created_at, created_by)
VALUES (1, '123 Main St', NULL, 'Chicago', 'IL', '60606', 'United States', CURRENT_TIMESTAMP, 'dkotowski');

UPDATE addresses
SET address_line_2 = 'Suite 100',
    updated_at = CURRENT_TIMESTAMP,
    updated_by = 'dkotowski'
WHERE id = 1;

DELETE FROM addresses
WHERE id = 1;
