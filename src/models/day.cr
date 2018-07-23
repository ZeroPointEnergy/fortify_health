class Day
  @nutrition_fact : NutritionFact?

  property date : String
  property user : User
  property meals : Array(Meal)

  def initialize(@date : String, @user : User)
    @meals = [] of Meal
  end

  def nutrition_fact
    nf = @nutrition_fact
    if nf.nil?
      nf = NutritionFact.sum(nutrition_facts)
      @nutrition_fact = nf
    end
    nf
  end

  private def nutrition_facts
    @meals.map(&.nutrition_fact)
  end
end
