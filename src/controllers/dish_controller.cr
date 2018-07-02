class DishController < ApplicationController
  def index
    dishes = Dish.all
    render("index.slang")
  end

  def show
    if dish = Dish.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "Dish with ID #{params["id"]} Not Found"
      redirect_to "/dishes"
    end
  end

  def new
    dish = Dish.new
    render("new.slang")
  end

  def create
    dish = Dish.new(dish_params.validate!)

    if dish.valid? && dish.save
      flash["success"] = "Created Dish successfully."
      redirect_to "/dishes"
    else
      flash["danger"] = "Could not create Dish!"
      render("new.slang")
    end
  end

  def edit
    if dish = Dish.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Dish with ID #{params["id"]} Not Found"
      redirect_to "/dishes"
    end
  end

  def update
    if dish = Dish.find(params["id"])
      dish.set_attributes(dish_params.validate!)
      if dish.valid? && dish.save
        flash["success"] = "Updated Dish successfully."
        redirect_to "/dishes"
      else
        flash["danger"] = "Could not update Dish!"
        render("edit.slang")
      end
    else
      flash["warning"] = "Dish with ID #{params["id"]} Not Found"
      redirect_to "/dishes"
    end
  end

  def destroy
    if dish = Dish.find params["id"]
      dish.destroy
    else
      flash["warning"] = "Dish with ID #{params["id"]} Not Found"
    end
    redirect_to "/dishes"
  end

  def dish_params
    params.validation do
      required(:recipe_id) { |f| !f.nil? }
      required(:meal_id) { |f| !f.nil? }
      required(:nutrition_fact_id) { |f| !f.nil? }
    end
  end
end
