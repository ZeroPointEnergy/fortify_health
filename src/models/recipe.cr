class Recipe < Granite::Base
  adapter pg
  table_name recipes

  belongs_to :user
  has_many :ingrediants

  # id : Int64 primary key is created for you
  field name : String
  timestamps

  after_destroy :cleanup

  def cleanup
    ingrediants.each do |ingrediant|
      ingrediant.destroy
    end
  end

  def nutrition_facts
    ingrediants.map{|i| i.nutrition_fact}
  end

  def nutrition_fact
    NutritionFact.sum(nutrition_facts)
  end
end
