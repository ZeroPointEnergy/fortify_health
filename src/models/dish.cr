class Dish < Granite::Base
  adapter pg
  table_name dishes

  belongs_to :recipe, class_name: Recipe
  belongs_to :meal, class_name: Meal
  belongs_to :nutrition_fact, class_name: NutritionFact

  # id : Int64 primary key is created for you
  timestamps

  after_destroy :cleanup

  def cleanup
    if fact = nutrition_fact
      fact.destroy
    end
  end
end
