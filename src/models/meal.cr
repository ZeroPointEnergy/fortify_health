class Meal < Granite::Base
  adapter pg
  table_name meals

  belongs_to :user

  belongs_to :nutrition_fact

  # id : Int64 primary key is created for you
  field time : Time
  timestamps
end
