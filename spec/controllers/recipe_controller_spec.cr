require "./spec_helper"

def recipe_hash
  {"name" => "Fake", "user_id" => "1"}
end

def recipe_params
  params = [] of String
  params << "name=#{recipe_hash["name"]}"
  params << "user_id=#{recipe_hash["user_id"]}"
  params.join("&")
end

def create_recipe
  model = Recipe.new(recipe_hash)
  model.save
  model
end

class RecipeControllerTest < GarnetSpec::Controller::Test
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

describe RecipeControllerTest do
  subject = RecipeControllerTest.new

  it "renders recipe index template" do
    Recipe.clear
    response = subject.get "/recipes"

    response.status_code.should eq(200)
    response.body.should contain("recipes")
  end

  it "renders recipe show template" do
    Recipe.clear
    model = create_recipe
    location = "/recipes/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Recipe")
  end

  it "renders recipe new template" do
    Recipe.clear
    location = "/recipes/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Recipe")
  end

  it "renders recipe edit template" do
    Recipe.clear
    model = create_recipe
    location = "/recipes/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Recipe")
  end

  it "creates a recipe" do
    Recipe.clear
    response = subject.post "/recipes", body: recipe_params

    response.headers["Location"].should eq "/recipes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a recipe" do
    Recipe.clear
    model = create_recipe
    response = subject.patch "/recipes/#{model.id}", body: recipe_params

    response.headers["Location"].should eq "/recipes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a recipe" do
    Recipe.clear
    model = create_recipe
    response = subject.delete "/recipes/#{model.id}"

    response.headers["Location"].should eq "/recipes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
