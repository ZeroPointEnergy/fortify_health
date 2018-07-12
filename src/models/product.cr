class Product < Granite::Base
  adapter pg
  table_name products

  belongs_to :user
  belongs_to :product_source
  belongs_to :nutrition_fact

  # id : Int64 primary key is created for you
  field name : String
  field unit : String
  field amount : Float64
  field external_id : String
  timestamps

  after_destroy :cleanup

  def cleanup
    if fact = nutrition_fact
      fact.destroy
    end
  end

  def portion(amount : Float64, unit : String)
    if unit != self.unit
      raise "Unit convertion is not supported yet"
    else
      nutrition_fact * (amount / (self.amount || 1.0))
    end
  end

end
