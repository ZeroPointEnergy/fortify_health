class Ingrediant < Granite::Base
  adapter pg
  table_name ingrediants

  belongs_to :recipe, class_name: Recipe
  belongs_to :product, class_name: Product
  belongs_to :user, class_name: User

  # id : Int64 primary key is created for you
  field unit : String
  field amount : Float64
  timestamps

  def nutrition_fact
    product.portion(amount || 0.0, unit || "")
  end
end
