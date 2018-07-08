class MealController < ApplicationController
  before_action do
    all { redirect_signed_out_user }
  end

  def index
    if (user = current_user)
      meals = user.meals
      render("index.slang")
    end
  end

  def show
    if meal = Meal.find params["id"]
      if nutrition_fact = meal.nutrition_fact
        render("show.slang")
      else
        flash["warning"] = "Nutrition Facts for meal #{meal.time.to_s} Not Found"
        redirect_to "/meals"
      end
    else
      flash["warning"] = "Meal with ID #{params["id"]} Not Found"
      redirect_to "/meals"
    end
  end

  def new
    meal = Meal.new(time: Time.utc_now)
    render("new.slang")
  end

  def create
    if (user = current_user)
      meal = Meal.new
      meal.set_time(meal_params.validate!)
      nutrition_fact = NutritionFact.new(calories: 0)
      if nutrition_fact.valid? && nutrition_fact.save
        meal.user_id = user.id
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
  end

  def edit
    if meal = Meal.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Meal with ID #{params["id"]} Not Found"
      redirect_to "/meals"
    end
  end

  def update
    if meal = Meal.find(params["id"])
      meal.set_attributes(meal_params.validate!)
      if meal.valid? && meal.save
        flash["success"] = "Updated Meal successfully."
        redirect_to "/meals"
      else
        flash["danger"] = "Could not update Meal!"
        render("edit.slang")
      end
    else
      flash["warning"] = "Meal with ID #{params["id"]} Not Found"
      redirect_to "/meals"
    end
  end

  def destroy
    if meal = Meal.find params["id"]
      meal.destroy
    else
      flash["warning"] = "Meal with ID #{params["id"]} Not Found"
    end
    redirect_to "/meals"
  end

  def meal_params
    params.validation do
      required(:date, "Provide a date for the meal") { |f| !f.nil? }
      required(:time, "Provide a time for the meal") { |f| !f.nil? }
    end
  end
end
