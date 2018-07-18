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

  def set_time(params : Hash)
    time = params["time"]
    date = params["date"]
    if time && date
      self.time = user.parse_time(date, time).to_utc.at_beginning_of_second
    end
  end

  def self.by_days(user : User, days : Int32 = 0)
    res = {} of String => Array(Meal)
    all("WHERE user_id = ? ORDER BY time DESC", user.id).each do |meal|
      if time = meal.time
        date = user.format_date(time)
        res[date] ||= [] of Meal
        res[date] << meal
      else
        Amber.logger.error("Meal with id #{meal.id} does not have a valid time. Ignoring")
      end
    end
    res
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
