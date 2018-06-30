class ProductController < ApplicationController
  before_action do
    all { redirect_signed_out_user }
  end

  def index
    if (user = current_user)
      products = user.products
      render("index.slang")
    end
  end

  def show
    if product = Product.find params["id"]
      if nutrition_fact = product.nutrition_fact
        render("show.slang")
      else
        flash["warning"] = "Nutrition Facts for product #{product.name} Not Found"
        redirect_to "/products"
      end
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def new
    product = Product.new
    nutrition_fact = NutritionFact.new
    render("new.slang")
  end

  def create
    if (user = current_user)
      nutrition_fact = NutritionFact.new(nutrition_fact_params.validate!)

      if nutrition_fact.valid? && nutrition_fact.save
        product = Product.new(product_params.validate!)
        product.user_id = user.id
        product.nutrition_fact_id = nutrition_fact.id

        if product.valid? && product.save
          flash["success"] = "Created Product successfully."
          redirect_to "/products"
        else
          flash["danger"] = "Could not create Product!"
          render("new.slang")
        end
      end
    end
  end

  def edit
    if product = Product.find params["id"]
      if nutrition_fact = product.nutrition_fact
        render("edit.slang")
      else
        flash["warning"] = "Nutrition Facts for product #{product.name} Not Found"
        redirect_to "/products"
      end
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def update
    if product = Product.find(params["id"])
      if nutrition_fact = product.nutrition_fact
        product.set_attributes(product_params.validate!)
        nutrition_fact.set_attributes(nutrition_fact_params.validate!)

        if product.valid? && nutrition_fact.valid? && product.save && nutrition_fact.save
          flash["success"] = "Updated Product successfully."
          redirect_to "/products"
        else
          flash["danger"] = "Could not update Product!"
          render("edit.slang")
        end
      else
        flash["warning"] = "Nutrition Facts for product #{product.name} Not Found"
        redirect_to "/products"
      end
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def destroy
    if product = Product.find params["id"]
      product.destroy
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
    end
    redirect_to "/products"
  end

  def product_params
    params.validation do
      required(:name) { |f| !f.nil? }
      required(:unit) { |f| !f.nil? }
      required(:amount) { |f| !f.nil? }
    end
  end

  def nutrition_fact_params
    params.validation do
      required(:calories) { |f| !f.nil? }
      required(:fat) { |f| !f.nil? }
      required(:carbohydrate) { |f| !f.nil? }
      required(:protein) { |f| !f.nil? }
    end
  end
end
