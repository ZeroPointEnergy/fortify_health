class Product < Granite::Base
  adapter pg
  table_name products

  belongs_to :user

  belongs_to :nutrition_fact

  # id : Int64 primary key is created for you
  field name : String
  field unit : String
  field amount : Int32
  timestamps
end
