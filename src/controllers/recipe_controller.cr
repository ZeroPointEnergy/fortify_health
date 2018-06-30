class RecipeController < ApplicationController
  before_action do
    all { redirect_signed_out_user }
  end

  def index
    if (user = current_user)
      recipes = user.recipes
      render("index.slang")
    end
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
    if (user = current_user)
      recipe = Recipe.new(recipe_params.validate!)
      recipe.user_id = user.id

      if recipe.valid? && recipe.save
        flash["success"] = "Created Recipe successfully."
        redirect_to "/recipes/#{recipe.id}"
      else
        flash["danger"] = "Could not create Recipe!"
        render("new.slang")
      end
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
    end
  end
end
