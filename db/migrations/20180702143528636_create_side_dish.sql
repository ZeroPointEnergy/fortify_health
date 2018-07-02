-- +micrate Up
CREATE TABLE side_dishes (
  id BIGSERIAL PRIMARY KEY,
  product_id BIGINT,
  meal_id BIGINT,
  unit VARCHAR,
  amount INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX side_dish_product_id_idx ON side_dishes (product_id);
CREATE INDEX side_dish_meal_id_idx ON side_dishes (meal_id);

-- +micrate Down
DROP TABLE IF EXISTS side_dishes;
