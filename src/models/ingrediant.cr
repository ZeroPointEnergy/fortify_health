class Ingrediant < Granite::Base
  adapter pg
  table_name ingrediants

  belongs_to :recipe

  belongs_to :product

  belongs_to :user

  # id : Int64 primary key is created for you
  field unit : String
  field amount : Float64
  timestamps

  def nutrition_fact
    product.portion(amount || 0.0, unit || "")
  end
end
