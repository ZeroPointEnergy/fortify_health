class SideDishController < ApplicationController
  def index
    side_dishes = SideDish.all
    render("index.slang")
  end

  def show
    if side_dish = SideDish.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "SideDish with ID #{params["id"]} Not Found"
      redirect_to "/side_dishes"
    end
  end

  def new
    side_dish = SideDish.new
    render("new.slang")
  end

  def create
    side_dish = SideDish.new(side_dish_params.validate!)

    if side_dish.valid? && side_dish.save
      flash["success"] = "Created SideDish successfully."
      redirect_to "/side_dishes"
    else
      flash["danger"] = "Could not create SideDish!"
      render("new.slang")
    end
  end

  def edit
    if side_dish = SideDish.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "SideDish with ID #{params["id"]} Not Found"
      redirect_to "/side_dishes"
    end
  end

  def update
    if side_dish = SideDish.find(params["id"])
      side_dish.set_attributes(side_dish_params.validate!)
      if side_dish.valid? && side_dish.save
        flash["success"] = "Updated SideDish successfully."
        redirect_to "/side_dishes"
      else
        flash["danger"] = "Could not update SideDish!"
        render("edit.slang")
      end
    else
      flash["warning"] = "SideDish with ID #{params["id"]} Not Found"
      redirect_to "/side_dishes"
    end
  end

  def destroy
    if side_dish = SideDish.find params["id"]
      side_dish.destroy
    else
      flash["warning"] = "SideDish with ID #{params["id"]} Not Found"
    end
    redirect_to "/side_dishes"
  end

  def side_dish_params
    params.validation do
      required(:product_id) { |f| !f.nil? }
      required(:meal_id) { |f| !f.nil? }
      required(:unit) { |f| !f.nil? }
      required(:amount) { |f| !f.nil? }
    end
  end
end
