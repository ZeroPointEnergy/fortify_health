class DishController < ApplicationController
  before_action do
    all { redirect_signed_out_user }
  end

  def with_meal
    if meal = Meal.find(params["meal_id"])
      yield(meal)
    else
      flash["warning"] = "Meal with ID #{params["meal_id"]} Not Found"
      redirect_to "/meals"
    end
  end

  def new
    with_meal do |meal|
      dish = Dish.new
      render("new.slang")
    end
  end

  def create
    with_meal do |meal|
      create_params = dish_params.validate!
      dish = Dish.new(create_params)
      dish.meal_id = meal.id

      serving = (create_params["serving"] || 1.0).to_f
      nutrition_fact = dish.recipe.nutrition_fact * serving

      if nutrition_fact.valid? && nutrition_fact.save
        dish.nutrition_fact_id = nutrition_fact.id

        if dish.valid? && dish.save
          flash["success"] = "Created Dish successfully."
          meal.update_nutrition_facts
          redirect_to "/meals/#{meal.id}"
        else
          flash["danger"] = "Could not create Dish!"
          render("new.slang")
        end
      else
        flash["danger"] = "Could not create Dish!"
        render("new.slang")
      end
    end
  end

  def destroy
    with_meal do |meal|
      if dish = Dish.find params["id"]
        dish.destroy
        meal.update_nutrition_facts
      else
        flash["warning"] = "Dish with ID #{params["id"]} Not Found"
      end
      redirect_to "/meals/#{meal.id}"
    end
  end

  def dish_params
    params.validation do
      required(:recipe_id) { |f| !f.nil? }
      required(:serving) { |f| !f.nil? }
    end
  end

end
