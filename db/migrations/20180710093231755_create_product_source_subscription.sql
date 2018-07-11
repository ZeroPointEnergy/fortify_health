-- +micrate Up
CREATE TABLE product_source_subscriptions (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  product_source_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX product_source_subscription_user_id_idx ON product_source_subscriptions (user_id);
CREATE INDEX product_source_subscription_product_source_id_idx ON product_source_subscriptions (product_source_id);

-- +micrate Down
DROP TABLE IF EXISTS product_source_subscriptions;
