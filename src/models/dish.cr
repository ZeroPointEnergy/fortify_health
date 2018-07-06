class Dish < Granite::Base
  adapter pg
  table_name dishes

  belongs_to :recipe
  belongs_to :meal
  belongs_to :nutrition_fact

  # id : Int64 primary key is created for you
  timestamps

  after_destroy :cleanup

  def cleanup
    if fact = nutrition_fact
      fact.destroy
    end
  end
end
