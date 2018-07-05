class SideDishController < ApplicationController
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
      side_dish = SideDish.new
      render("new.slang")
    end
  end

  def create
    with_meal do |meal|
      side_dish = SideDish.new(side_dish_params.validate!)
      side_dish.meal_id = meal.id

      if side_dish.valid? && side_dish.save
        flash["success"] = "Created SideDish successfully."
        meal.update_nutrition_facts
        redirect_to "/meals/#{meal.id}"
      else
        flash["danger"] = "Could not create SideDish!"
        render("new.slang")
      end
    end
  end

  def edit
    with_meal do |meal|
      if side_dish = SideDish.find params["id"]
        render("edit.slang")
      else
        flash["warning"] = "SideDish with ID #{params["id"]} Not Found"
        redirect_to "/meals/#{meal.id}"
      end
    end
  end

  def update
    with_meal do |meal|
      if side_dish = SideDish.find(params["id"])
        side_dish.set_attributes(side_dish_params.validate!)
        if side_dish.valid? && side_dish.save
          flash["success"] = "Updated SideDish successfully."
          meal.update_nutrition_facts
          redirect_to "/meals/#{meal.id}"
        else
          flash["danger"] = "Could not update SideDish!"
          render("edit.slang")
        end
      else
        flash["warning"] = "SideDish with ID #{params["id"]} Not Found"
        redirect_to "/meals/#{meal.id}"
      end
    end
  end

  def destroy
    with_meal do |meal|
      if side_dish = SideDish.find params["id"]
        side_dish.destroy
        meal.update_nutrition_facts
      else
        flash["warning"] = "SideDish with ID #{params["id"]} Not Found"
      end
      redirect_to "/meals/#{meal.id}"
    end
  end

  def side_dish_params
    params.validation do
      required(:product_id) { |f| !f.nil? }
      required(:unit) { |f| !f.nil? }
      required(:amount) { |f| !f.nil? }
    end
  end
end
