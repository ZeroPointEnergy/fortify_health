-- +micrate Up
CREATE TABLE nutrition_facts (
  id BIGSERIAL PRIMARY KEY,
  calories FLOAT,
  fat FLOAT,
  carbohydrate FLOAT,
  protein FLOAT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS nutrition_facts;
