-- +micrate Up
CREATE TABLE nutrition_facts (
  id BIGSERIAL PRIMARY KEY,
  calories INT,
  fat INT,
  carbohydrate INT,
  protein INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS nutrition_facts;
