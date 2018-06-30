class RecipeController < ApplicationController
  def index
    recipes = Recipe.all
    render("index.slang")
  end

  def show
    if recipe = Recipe.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "Recipe with ID #{params["id"]} Not Found"
      redirect_to "/recipes"
    end
  end

  def new
    recipe = Recipe.new
    render("new.slang")
  end

  def create
    recipe = Recipe.new(recipe_params.validate!)

    if recipe.valid? && recipe.save
      flash["success"] = "Created Recipe successfully."
      redirect_to "/recipes"
    else
      flash["danger"] = "Could not create Recipe!"
      render("new.slang")
    end
  end

  def edit
    if recipe = Recipe.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Recipe with ID #{params["id"]} Not Found"
      redirect_to "/recipes"
    end
  end

  def update
    if recipe = Recipe.find(params["id"])
      recipe.set_attributes(recipe_params.validate!)
      if recipe.valid? && recipe.save
        flash["success"] = "Updated Recipe successfully."
        redirect_to "/recipes"
      else
        flash["danger"] = "Could not update Recipe!"
        render("edit.slang")
      end
    else
      flash["warning"] = "Recipe with ID #{params["id"]} Not Found"
      redirect_to "/recipes"
    end
  end

  def destroy
    if recipe = Recipe.find params["id"]
      recipe.destroy
    else
      flash["warning"] = "Recipe with ID #{params["id"]} Not Found"
    end
    redirect_to "/recipes"
  end

  def recipe_params
    params.validation do
      required(:name) { |f| !f.nil? }
      required(:user_id) { |f| !f.nil? }
    end
  end
end
