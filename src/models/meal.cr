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

  after_destroy :cleanup

  def date_input
    (time || Time.now).to_s("%Y-%m-%d")
  end

  def time_input
    (time || Time.now).to_s("%H:%M:%S")
  end

  def set_time(params : Hash)
    time = params["time"]
    date = params["date"]
    if time && date
      # TODO: implement timezone correctly
      t = Time.parse("#{date} #{time} UTC", "%Y-%m-%d %H:%M:%S %z")
      self.time = t.at_beginning_of_second
    end
  end

  def cleanup
    if fact = nutrition_fact
      fact.destroy
    end
    dishes.each { |dish| dish.destroy }
    side_dishes.each { |side_dish| side_dish.destroy }
  end

  def update_nutrition_facts
    facts = dishes.map{|d| d.nutrition_fact}
    facts += side_dishes.map{|d| d.nutrition_fact}
    fact = nutrition_fact
    fact.sum(facts)
    fact.save
  end
end