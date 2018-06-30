-- +micrate Up
CREATE TABLE recipes (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  user_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX recipe_user_id_idx ON recipes (user_id);

-- +micrate Down
DROP TABLE IF EXISTS recipes;
