-- +micrate Up
CREATE TABLE dishes (
  id BIGSERIAL PRIMARY KEY,
  recipe_id BIGINT,
  meal_id BIGINT,
  nutrition_fact_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX dish_recipe_id_idx ON dishes (recipe_id);
CREATE INDEX dish_meal_id_idx ON dishes (meal_id);
CREATE INDEX dish_nutrition_fact_id_idx ON dishes (nutrition_fact_id);

-- +micrate Down
DROP TABLE IF EXISTS dishes;
