-- +micrate Up
CREATE TABLE product_sources (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR,
  url VARCHAR,
  notes TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);


-- +micrate Down
DROP TABLE IF EXISTS product_sources;
