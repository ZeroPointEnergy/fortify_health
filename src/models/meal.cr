class Meal < Granite::Base
  adapter pg
  table_name meals

  belongs_to :user
  belongs_to :nutrition_fact

  #has_many :dishes
  # FIXME: Granite lacks an inflector
  def dishes
    Granite::AssociationCollection(self, Dish).new(self)
  end

  #has_many :side_dishes
  # FIXME: Granite lacks an inflector
  def side_dishes
    Granite::AssociationCollection(self, SideDish).new(self)
  end

  # id : Int64 primary key is created for you
  field time : Time
  timestamps

  def update_nutrition_facts
    facts = dishes.map{|d| d.nutrition_fact}
    facts += side_dishes.map{|d| d.nutrition_fact}
    fact = nutrition_fact
    fact.sum(facts)
    fact.save
  end
end
