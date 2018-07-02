class NutritionFact < Granite::Base
  adapter pg
  table_name nutrition_facts

  # id : Int64 primary key is created for you
  field calories : Int32
  field fat : Int32
  field carbohydrate : Int32
  field protein : Int32
  timestamps

  def self.sum(facts : Array(NutritionFact))
    NutritionFact.new(
      calories: facts.map{|f| f.calories || 0}.sum(0),
      fat: facts.map{|f| f.fat || 0}.sum(0),
      carbohydrate: facts.map{|f| f.carbohydrate || 0}.sum(0),
      protein: facts.map{|f| f.protein || 0}.sum(0),
    )
  end

  def *(factor : Float)
    NutritionFact.new(
      calories: ((calories || 0)* factor).to_i,
      fat: ((fat || 0) * factor).to_i,
      carbohydrate: ((carbohydrate || 0) * factor).to_i,
      protein: ((protein || 0) * factor).to_i,
    )
  end
end
