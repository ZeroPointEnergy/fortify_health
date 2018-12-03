class ProductSource < Granite::Base
  adapter pg
  table_name product_sources

  # id : Int64 primary key is created for you
  field name : String
  field url : String
  field notes : String
  timestamps

  has_many :products, class_name: Product

  after_destroy :cleanup

  def cleanup
    products.each(&.destroy)
  end
end
