class IngrediantController < ApplicationController
  def index
    ingrediants = Ingrediant.all
    render("index.slang")
  end

  def show
    if ingrediant = Ingrediant.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
      redirect_to "/ingrediants"
    end
  end

  def new
    ingrediant = Ingrediant.new
    render("new.slang")
  end

  def create
    ingrediant = Ingrediant.new(ingrediant_params.validate!)

    if ingrediant.valid? && ingrediant.save
      flash["success"] = "Created Ingrediant successfully."
      redirect_to "/ingrediants"
    else
      flash["danger"] = "Could not create Ingrediant!"
      render("new.slang")
    end
  end

  def edit
    if ingrediant = Ingrediant.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
      redirect_to "/ingrediants"
    end
  end

  def update
    if ingrediant = Ingrediant.find(params["id"])
      ingrediant.set_attributes(ingrediant_params.validate!)
      if ingrediant.valid? && ingrediant.save
        flash["success"] = "Updated Ingrediant successfully."
        redirect_to "/ingrediants"
      else
        flash["danger"] = "Could not update Ingrediant!"
        render("edit.slang")
      end
    else
      flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
      redirect_to "/ingrediants"
    end
  end

  def destroy
    if ingrediant = Ingrediant.find params["id"]
      ingrediant.destroy
    else
      flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
    end
    redirect_to "/ingrediants"
  end

  def ingrediant_params
    params.validation do
      required(:recipe_id) { |f| !f.nil? }
      required(:product_id) { |f| !f.nil? }
      required(:user_id) { |f| !f.nil? }
      required(:unit) { |f| !f.nil? }
      required(:amount) { |f| !f.nil? }
    end
  end
end
