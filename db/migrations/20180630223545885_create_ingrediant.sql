-- +micrate Up
CREATE TABLE ingrediants (
  id BIGSERIAL PRIMARY KEY,
  recipe_id BIGINT,
  product_id BIGINT,
  user_id BIGINT,
  unit VARCHAR,
  amount INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX ingrediant_recipe_id_idx ON ingrediants (recipe_id);
CREATE INDEX ingrediant_product_id_idx ON ingrediants (product_id);
CREATE INDEX ingrediant_user_id_idx ON ingrediants (user_id);

-- +micrate Down
DROP TABLE IF EXISTS ingrediants;
