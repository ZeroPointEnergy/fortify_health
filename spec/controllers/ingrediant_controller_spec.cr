require "./spec_helper"

def ingrediant_hash
  {"recipe_id" => "1", "product_id" => "1", "user_id" => "1", "unit" => "Fake", "amount" => "1"}
end

def ingrediant_params
  params = [] of String
  params << "recipe_id=#{ingrediant_hash["recipe_id"]}"
  params << "product_id=#{ingrediant_hash["product_id"]}"
  params << "user_id=#{ingrediant_hash["user_id"]}"
  params << "unit=#{ingrediant_hash["unit"]}"
  params << "amount=#{ingrediant_hash["amount"]}"
  params.join("&")
end

def create_ingrediant
  model = Ingrediant.new(ingrediant_hash)
  model.save
  model
end

class IngrediantControllerTest < GarnetSpec::Controller::Test
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

describe IngrediantControllerTest do
  subject = IngrediantControllerTest.new

  it "renders ingrediant index template" do
    Ingrediant.clear
    response = subject.get "/ingrediants"

    response.status_code.should eq(200)
    response.body.should contain("ingrediants")
  end

  it "renders ingrediant show template" do
    Ingrediant.clear
    model = create_ingrediant
    location = "/ingrediants/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Ingrediant")
  end

  it "renders ingrediant new template" do
    Ingrediant.clear
    location = "/ingrediants/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Ingrediant")
  end

  it "renders ingrediant edit template" do
    Ingrediant.clear
    model = create_ingrediant
    location = "/ingrediants/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Ingrediant")
  end

  it "creates a ingrediant" do
    Ingrediant.clear
    response = subject.post "/ingrediants", body: ingrediant_params

    response.headers["Location"].should eq "/ingrediants"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a ingrediant" do
    Ingrediant.clear
    model = create_ingrediant
    response = subject.patch "/ingrediants/#{model.id}", body: ingrediant_params

    response.headers["Location"].should eq "/ingrediants"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a ingrediant" do
    Ingrediant.clear
    model = create_ingrediant
    response = subject.delete "/ingrediants/#{model.id}"

    response.headers["Location"].should eq "/ingrediants"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
