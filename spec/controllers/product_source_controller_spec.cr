require "./spec_helper"

def product_source_hash
  {"name" => "Fake", "url" => "Fake", "notes" => "Fake"}
end

def product_source_params
  params = [] of String
  params << "name=#{product_source_hash["name"]}"
  params << "url=#{product_source_hash["url"]}"
  params << "notes=#{product_source_hash["notes"]}"
  params.join("&")
end

def create_product_source
  model = ProductSource.new(product_source_hash)
  model.save
  model
end

class ProductSourceControllerTest < GarnetSpec::Controller::Test
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

describe ProductSourceControllerTest do
  subject = ProductSourceControllerTest.new

  it "renders product_source index template" do
    ProductSource.clear
    response = subject.get "/product_sources"

    response.status_code.should eq(200)
    response.body.should contain("product_sources")
  end

  it "renders product_source show template" do
    ProductSource.clear
    model = create_product_source
    location = "/product_sources/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Product Source")
  end

  it "renders product_source new template" do
    ProductSource.clear
    location = "/product_sources/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Product Source")
  end

  it "renders product_source edit template" do
    ProductSource.clear
    model = create_product_source
    location = "/product_sources/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Product Source")
  end

  it "creates a product_source" do
    ProductSource.clear
    response = subject.post "/product_sources", body: product_source_params

    response.headers["Location"].should eq "/product_sources"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a product_source" do
    ProductSource.clear
    model = create_product_source
    response = subject.patch "/product_sources/#{model.id}", body: product_source_params

    response.headers["Location"].should eq "/product_sources"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a product_source" do
    ProductSource.clear
    model = create_product_source
    response = subject.delete "/product_sources/#{model.id}"

    response.headers["Location"].should eq "/product_sources"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
