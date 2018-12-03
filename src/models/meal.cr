class Meal < Granite::Base
  adapter pg
  table_name meals

  belongs_to :user, class_name: User
  belongs_to :nutrition_fact, class_name: NutritionFact
  has_many :dishes, class_name: Dish
  has_many :side_dishes, class_name: SideDish

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

  def self.days(user : User, days : Int32 = 0)
    res = {} of String => Day
    all("WHERE user_id = ? ORDER BY time DESC", user.id).each do |meal|
      if time = meal.time
        date = user.format_date(time)
        res[date] ||= Day.new(date: date, user: user)
        res[date].meals << meal
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
