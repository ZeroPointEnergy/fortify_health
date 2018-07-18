class MealController < ApplicationController
  before_action do
    all { redirect_signed_out_user }
  end

  def index
    user = get_user
    render("index.slang")
  end

  def show
    meal = resolve(params["id"], Meal)
    if nutrition_fact = meal.nutrition_fact
      render("show.slang")
    else
      flash["warning"] = "Nutrition Facts for meal #{meal.time.to_s} Not Found"
      redirect_to "/meals"
    end
  end

  def new
    user = get_user
    meal = Meal.new
    meal.user = user
    render("new.slang")
  end

  def create
    user = get_user
    meal = Meal.new
    meal.user = user
    meal.set_time(meal_params.validate!)
    nutrition_fact = NutritionFact.new(calories: 0.0)

    if nutrition_fact.valid? && nutrition_fact.save
      meal.nutrition_fact_id = nutrition_fact.id

      if meal.valid? && meal.save
        flash["success"] = "Created Meal successfully."
        redirect_to "/meals"
      else
        flash["danger"] = "Could not create Meal!"
        render("new.slang")
      end
    else
      flash["danger"] = "Could not create Meal!"
      render("new.slang")
    end
  end

  def edit
    meal = resolve(params["id"], Meal)
    render("edit.slang")
  end

  def update
    meal = resolve(params["id"], Meal)
    meal.set_time(meal_params.validate!)
    if meal.valid? && meal.save
      flash["success"] = "Updated Meal successfully."
      redirect_to "/meals"
    else
      flash["danger"] = "Could not update Meal!"
      render("edit.slang")
    end
  end

  def destroy
    meal = resolve(params["id"], Meal)
    meal.destroy
    redirect_to "/meals"
  end

  def meal_params
    params.validation do
      required(:date, "Provide a date for the meal") { |f| !f.nil? }
      required(:time, "Provide a time for the meal") { |f| !f.nil? }
    end
  end
end
