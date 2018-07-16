class IngrediantController < ApplicationController
  before_action do
    all { redirect_signed_out_user }
  end

  def new
    user = get_user
    recipe = resolve(params["recipe_id"], Recipe)
    ingrediant = Ingrediant.new
    render("new.slang")
  end

  def create
    user = get_user
    recipe = resolve(params["recipe_id"], Recipe)
    ingrediant = Ingrediant.new(create_params.validate!)
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

  def edit
    user = get_user
    recipe = resolve(params["recipe_id"], Recipe)
    if ingrediant = Ingrediant.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
      redirect_to "/recipes/#{recipe.id}"
    end
  end

  def update
    user = get_user
    recipe = resolve(params["recipe_id"], Recipe)
    if ingrediant = Ingrediant.find(params["id"])
      ingrediant.set_attributes(update_params.validate!)
      if ingrediant.valid? && ingrediant.save
        flash["success"] = "Updated Ingrediant successfully."
        redirect_to "/recipes/#{recipe.id}"
      else
        flash["danger"] = "Could not update Ingrediant!"
        render("edit.slang")
      end
    else
      flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
      redirect_to "/recipes/#{recipe.id}"
    end
  end

  def destroy
    recipe = resolve(params["recipe_id"], Recipe)
    if ingrediant = Ingrediant.find params["id"]
      ingrediant.destroy
    else
      flash["warning"] = "Ingrediant with ID #{params["id"]} Not Found"
    end
    redirect_to "/recipes/#{recipe.id}"
  end

  def create_params
    params.validation do
      required(:product_id) { |f| !f.nil? }
      required(:unit) { |f| !f.nil? }
      required(:amount) { |f| !f.nil? }
    end
  end

  def update_params
    params.validation do
      required(:unit) { |f| !f.nil? }
      required(:amount) { |f| !f.nil? }
    end
  end
end
