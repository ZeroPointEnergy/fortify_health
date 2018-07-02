require "./spec_helper"

def meal_hash
  {"time" => "2018-07-02 14:35:07 +02:00", "user_id" => "1", "nutrition_fact_id" => "1"}
end

def meal_params
  params = [] of String
  params << "time=#{meal_hash["time"]}"
  params << "user_id=#{meal_hash["user_id"]}"
  params << "nutrition_fact_id=#{meal_hash["nutrition_fact_id"]}"
  params.join("&")
end

def create_meal
  model = Meal.new(meal_hash)
  model.save
  model
end

class MealControllerTest < GarnetSpec::Controller::Test
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

describe MealControllerTest do
  subject = MealControllerTest.new

  it "renders meal index template" do
    Meal.clear
    response = subject.get "/meals"

    response.status_code.should eq(200)
    response.body.should contain("meals")
  end

  it "renders meal show template" do
    Meal.clear
    model = create_meal
    location = "/meals/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Meal")
  end

  it "renders meal new template" do
    Meal.clear
    location = "/meals/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Meal")
  end

  it "renders meal edit template" do
    Meal.clear
    model = create_meal
    location = "/meals/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Meal")
  end

  it "creates a meal" do
    Meal.clear
    response = subject.post "/meals", body: meal_params

    response.headers["Location"].should eq "/meals"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a meal" do
    Meal.clear
    model = create_meal
    response = subject.patch "/meals/#{model.id}", body: meal_params

    response.headers["Location"].should eq "/meals"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a meal" do
    Meal.clear
    model = create_meal
    response = subject.delete "/meals/#{model.id}"

    response.headers["Location"].should eq "/meals"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
