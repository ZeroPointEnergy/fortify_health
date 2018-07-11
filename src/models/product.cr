class Product < Granite::Base
  adapter pg
  table_name products

  belongs_to :user
  belongs_to :product_source
  belongs_to :nutrition_fact

  # id : Int64 primary key is created for you
  field name : String
  field unit : String
  field amount : Int32
  field external_id : Int32
  timestamps

  after_destroy :cleanup

  def cleanup
    if fact = nutrition_fact
      fact.destroy
    end
  end

  def portion(amount : Int32, unit : String)
    if unit != self.unit
      raise "Unit convertion is not supported yet"
    else
      nutrition_fact * (amount.to_f / (self.amount || 1).to_f)
    end
  end
end
