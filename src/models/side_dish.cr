class SideDish < Granite::Base
  adapter pg
  table_name side_dishes

  belongs_to :product

  belongs_to :meal

  # id : Int64 primary key is created for you
  field unit : String
  field amount : Int32
  timestamps
end
