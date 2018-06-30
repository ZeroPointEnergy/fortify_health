class Ingrediant < Granite::Base
  adapter pg
  table_name ingrediants

  belongs_to :recipe

  belongs_to :product

  belongs_to :user

  # id : Int64 primary key is created for you
  field unit : String
  field amount : Int32
  timestamps
end
