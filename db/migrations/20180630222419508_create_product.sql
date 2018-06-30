-- +micrate Up
CREATE TABLE products (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  user_id BIGINT,
  unit VARCHAR,
  amount INT,
  nutrition_fact_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX product_user_id_idx ON products (user_id);
CREATE INDEX product_nutrition_fact_id_idx ON products (nutrition_fact_id);

-- +micrate Down
DROP TABLE IF EXISTS products;
