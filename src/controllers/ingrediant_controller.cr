class IngrediantController < ApplicationController
  before_action do
    all { redirect_signed_out_user }
  end

  def with_recipe
    if recipe = Recipe.find(params["recipe_id"])
      yield(recipe)
    else
      flash["warning"] = "Recipe with ID #{params["recipe_id"]} Not Found"
      redirect_to "/recipes"
    end
  end

  def show
    with_recipe do |recipe|
      if ingrediant = Ingrediant.find params["id"]
        render("show.slang")
      else
        flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
        redirect_to "/recipes/#{recipe.id}"
      end
    end
  end

  def new
    with_recipe do |recipe|
      ingrediant = Ingrediant.new
      render("new.slang")
    end
  end

  def create
    if user = current_user
      with_recipe do |recipe|
        ingrediant = Ingrediant.new(ingrediant_params.validate!)
        ingrediant.recipe_id = recipe.id
        ingrediant.user_id = user.id

        if ingrediant.valid? && ingrediant.save
          flash["success"] = "Created Ingrediant successfully."
          redirect_to "/recipes/#{recipe.id}"
        else
          flash["danger"] = "Could not create Ingrediant!"
          render("new.slang")
        end
      end
    end
  end

  def edit
    with_recipe do |recipe|
      if ingrediant = Ingrediant.find params["id"]
        render("edit.slang")
      else
        flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
        redirect_to "/recipes/#{recipe.id}"
      end
    end
  end

  def update
    with_recipe do |recipe|
      if ingrediant = Ingrediant.find(params["id"])
        ingrediant.set_attributes(ingrediant_params.validate!)
        if ingrediant.valid? && ingrediant.save
          flash["success"] = "Updated Ingrediant successfully."
          redirect_to "/recipes/#{recipe.id}"
        else
          flash["danger"] = "Could not update Ingrediant!"
          render("edit.slang")
        end
      else
        flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
        #redirect_to "/recipes/#{recipe.id}"
      end
    end
  end

  def destroy
    with_recipe do |recipe|
      if ingrediant = Ingrediant.find params["id"]
        ingrediant.destroy
      else
        flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
      end
      redirect_to "/recipes/#{recipe.id}"
    end
  end

  def ingrediant_params
    params.validation do
      required(:product_id) { |f| !f.nil? }
      required(:unit) { |f| !f.nil? }
      required(:amount) { |f| !f.nil? }
    end
  end

end
