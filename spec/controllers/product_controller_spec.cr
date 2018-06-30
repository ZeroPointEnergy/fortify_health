require "./spec_helper"

def product_hash
  {"name" => "Fake", "user_id" => "1", "unit" => "Fake", "amount" => "1", "nutrition_fact_id" => "1"}
end

def product_params
  params = [] of String
  params << "name=#{product_hash["name"]}"
  params << "user_id=#{product_hash["user_id"]}"
  params << "unit=#{product_hash["unit"]}"
  params << "amount=#{product_hash["amount"]}"
  params << "nutrition_fact_id=#{product_hash["nutrition_fact_id"]}"
  params.join("&")
end

def create_product
  model = Product.new(product_hash)
  model.save
  model
end

class ProductControllerTest < GarnetSpec::Controller::Test
  getter handler : Amber::Pipe::Pipeline

  def initialize
    @handler = Amber::Pipe::Pipeline.new
    @handler.build :web do
      plug Amber::Pipe::Error.new
      plug Amber::Pipe::Session.new
      plug Amber::Pipe::Flash.new
    end
    @handler.prepare_pipelines
  end
end

describe ProductControllerTest do
  subject = ProductControllerTest.new

  it "renders product index template" do
    Product.clear
    response = subject.get "/products"

    response.status_code.should eq(200)
    response.body.should contain("products")
  end

  it "renders product show template" do
    Product.clear
    model = create_product
    location = "/products/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Product")
  end

  it "renders product new template" do
    Product.clear
    location = "/products/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Product")
  end

  it "renders product edit template" do
    Product.clear
    model = create_product
    location = "/products/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Product")
  end

  it "creates a product" do
    Product.clear
    response = subject.post "/products", body: product_params

    response.headers["Location"].should eq "/products"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a product" do
    Product.clear
    model = create_product
    response = subject.patch "/products/#{model.id}", body: product_params

    response.headers["Location"].should eq "/products"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a product" do
    Product.clear
    model = create_product
    response = subject.delete "/products/#{model.id}"

    response.headers["Location"].should eq "/products"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
