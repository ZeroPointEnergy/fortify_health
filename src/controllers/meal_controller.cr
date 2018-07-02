class MealController < ApplicationController
  def index
    meals = Meal.all
    render("index.slang")
  end

  def show
    if meal = Meal.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "Meal with ID #{params["id"]} Not Found"
      redirect_to "/meals"
    end
  end

  def new
    meal = Meal.new
    render("new.slang")
  end

  def create
    meal = Meal.new(meal_params.validate!)

    if meal.valid? && meal.save
      flash["success"] = "Created Meal successfully."
      redirect_to "/meals"
    else
      flash["danger"] = "Could not create Meal!"
      render("new.slang")
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
      required(:time) { |f| !f.nil? }
      required(:user_id) { |f| !f.nil? }
      required(:nutrition_fact_id) { |f| !f.nil? }
    end
  end
end
