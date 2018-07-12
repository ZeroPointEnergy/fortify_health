class NutritionFact < Granite::Base
  adapter pg
  table_name nutrition_facts

  # id : Int64 primary key is created for you
  field calories : Float64
  field fat : Float64
  field carbohydrate : Float64
  field protein : Float64
  timestamps

  def self.sum(nutrition_facts : Array(NutritionFact))
    NutritionFact.new(
      calories: nutrition_facts.map{|f| f.calories || 0}.sum(0),
      fat: nutrition_facts.map{|f| f.fat || 0}.sum(0),
      carbohydrate: nutrition_facts.map{|f| f.carbohydrate || 0}.sum(0),
      protein: nutrition_facts.map{|f| f.protein || 0}.sum(0),
    )
  end

  def *(factor : Float)
    NutritionFact.new(
      calories: ((calories || 0)* factor),
      fat: ((fat || 0) * factor),
      carbohydrate: ((carbohydrate || 0) * factor),
      protein: ((protein || 0) * factor),
    )
  end

  def sum(nutrition_facts : Array(NutritionFact))
    fact = NutritionFact.sum(nutrition_facts)

    self.calories = fact.calories
    self.fat = fact.fat
    self.carbohydrate = fact.carbohydrate
    self.protein = fact.protein
  end
end
