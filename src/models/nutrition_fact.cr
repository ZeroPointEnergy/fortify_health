class NutritionFact < Granite::Base
  adapter pg
  table_name nutrition_facts

  # id : Int64 primary key is created for you
  field calories : Int32
  field fat : Int32
  field carbohydrate : Int32
  field protein : Int32
  timestamps
end
