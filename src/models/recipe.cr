class Recipe < Granite::Base
  adapter pg
  table_name recipes

  belongs_to :user

  # id : Int64 primary key is created for you
  field name : String
  timestamps
end
