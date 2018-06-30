class ProductController < ApplicationController
  def index
    products = Product.all
    render("index.slang")
  end

  def show
    if product = Product.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def new
    product = Product.new
    render("new.slang")
  end

  def create
    product = Product.new(product_params.validate!)

    if product.valid? && product.save
      flash["success"] = "Created Product successfully."
      redirect_to "/products"
    else
      flash["danger"] = "Could not create Product!"
      render("new.slang")
    end
  end

  def edit
    if product = Product.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "Product with ID #{params["id"]} Not Found"
      redirect_to "/products"
    end
  end

  def update
    if product = Product.find(params["id"])
      product.set_attributes(product_params.validate!)
      if product.valid? && product.save
        flash["success"] = "Updated Product successfully."
        redirect_to "/products"
      else
        flash["danger"] = "Could not update Product!"
        render("edit.slang")
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
      required(:user_id) { |f| !f.nil? }
      required(:unit) { |f| !f.nil? }
      required(:amount) { |f| !f.nil? }
      required(:nutrition_fact_id) { |f| !f.nil? }
    end
  end
end
