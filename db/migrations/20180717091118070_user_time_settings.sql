-- +micrate Up
ALTER TABLE users
ADD COLUMN timezone VARCHAR,
ADD COLUMN twenty_four_hour_clock BOOLEAN;

-- +micrate Down
ALTER TABLE users
DROP COLUMN timezone,
DROP COLUMN twenty_four_hour_clock;
