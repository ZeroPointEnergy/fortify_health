require "./spec_helper"

def dish_hash
  {"recipe_id" => "1", "meal_id" => "1", "nutrition_fact_id" => "1"}
end

def dish_params
  params = [] of String
  params << "recipe_id=#{dish_hash["recipe_id"]}"
  params << "meal_id=#{dish_hash["meal_id"]}"
  params << "nutrition_fact_id=#{dish_hash["nutrition_fact_id"]}"
  params.join("&")
end

def create_dish
  model = Dish.new(dish_hash)
  model.save
  model
end

class DishControllerTest < GarnetSpec::Controller::Test
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

describe DishControllerTest do
  subject = DishControllerTest.new

  it "renders dish index template" do
    Dish.clear
    response = subject.get "/dishes"

    response.status_code.should eq(200)
    response.body.should contain("dishes")
  end

  it "renders dish show template" do
    Dish.clear
    model = create_dish
    location = "/dishes/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Dish")
  end

  it "renders dish new template" do
    Dish.clear
    location = "/dishes/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Dish")
  end

  it "renders dish edit template" do
    Dish.clear
    model = create_dish
    location = "/dishes/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Dish")
  end

  it "creates a dish" do
    Dish.clear
    response = subject.post "/dishes", body: dish_params

    response.headers["Location"].should eq "/dishes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a dish" do
    Dish.clear
    model = create_dish
    response = subject.patch "/dishes/#{model.id}", body: dish_params

    response.headers["Location"].should eq "/dishes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a dish" do
    Dish.clear
    model = create_dish
    response = subject.delete "/dishes/#{model.id}"

    response.headers["Location"].should eq "/dishes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
