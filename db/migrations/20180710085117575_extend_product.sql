-- +micrate Up
ALTER TABLE products
ADD COLUMN product_source_id BIGINT,
ADD COLUMN external_id VARCHAR;

-- +micrate Down
ALTER TABLE products
DROP COLUMN product_source_id,
DROP COLUMN external_id;
