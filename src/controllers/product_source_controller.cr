class ProductSourceController < ApplicationController
  def index
    user = get_user
    product_sources = ProductSource.all
    render("index.slang")
  end

  def show
    user = get_user
    if product_source = ProductSource.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "ProductSource with ID #{params["id"]} Not Found"
      redirect_to "/product_sources"
    end
  end

end
