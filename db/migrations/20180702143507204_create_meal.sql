-- +micrate Up
CREATE TABLE meals (
  id BIGSERIAL PRIMARY KEY,
  time TIMESTAMP,
  user_id BIGINT,
  nutrition_fact_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX meal_user_id_idx ON meals (user_id);
CREATE INDEX meal_nutrition_fact_id_idx ON meals (nutrition_fact_id);

-- +micrate Down
DROP TABLE IF EXISTS meals;
