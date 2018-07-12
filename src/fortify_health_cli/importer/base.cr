#
# Base importer class. This handles all the logic for
# importing a product into the application
#
class FortifyHelpCli::Importer::Base
  @@product_source : ProductSource?

  def self.set_product_source(name : String, url : String, notes : String)
    unless @@product_source = ProductSource.find_by(name: name)
      product_source = ProductSource.new(name: name, url: url, notes: notes)
      if product_source.valid? && product_source.save
        @@product_source = product_source
      else
        raise "Error while creating product source"
      end
    end
  end

  def product_source
    if product_source = @@product_source
      product_source
    else
      raise "Error: product_source was nil"
    end
  end

  # product
  property external_id : String
  property name : String
  property amount : Float64
  property unit : String
  # nutrition facts
  property calories : Float64
  property protein : Float64
  property carbohydrates : Float64
  property fat : Float64

  def initialize(
    @external_id,
    @name,
    @amount,
    @unit,
    @calories,
    @protein,
    @carbohydrates,
    @fat
    )
  end

  def import
    if product = get_product
      update_nutrition_fact(product.nutrition_fact)
      update_product(product)
    else
      nutrition_fact = create_nutrition_fact
      create_product(nutrition_fact)
    end
  rescue ex
    puts "Error on import [#{ex.class}]: #{ex.message}"
    puts ex.backtrace
  end

  def get_product
    Product.find_by(external_id: @external_id)
  end

  def update_nutrition_fact(nutrition_fact)
    nutrition_fact.set_attributes(
      calories: @calories,
      fat: @fat,
      carbohydrate: @carbohydrates,
      protein: @protein,
    )
    unless nutrition_fact.valid? && nutrition_fact.save
      raise "Could not update nutrition_fact: #{nutrition_fact.errors.inspect}"
    end
  end

  def update_product(product)
    product.set_attributes(
      name: @name,
      amount: @amount,
      unit: @unit,
    )
    unless product.valid? && product.save
      raise "Could not update product: #{product.errors.inspect}"
    end
  end

  def create_nutrition_fact
    nutrition_fact = NutritionFact.new(
      calories: @calories,
      fat: @fat,
      carbohydrate: @carbohydrates,
      protein: @protein,
    )
    if nutrition_fact.valid? && nutrition_fact.save
      nutrition_fact
    else
      raise "Could not create nutrition_fact: #{nutrition_fact.errors.inspect}"
    end
  end

  def create_product(nutrition_fact)
    product = Product.new(
      external_id: @external_id,
      product_source_id: product_source.id,
      nutrition_fact_id: nutrition_fact.id,
      name: @name,
      amount: @amount,
      unit: @unit,
    )
    unless product.valid? && product.save
      raise "Could not create product: #{product.errors.inspect}"
    end
  end

end
