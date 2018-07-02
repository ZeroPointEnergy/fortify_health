require "./spec_helper"

def side_dish_hash
  {"product_id" => "1", "meal_id" => "1", "unit" => "Fake", "amount" => "1"}
end

def side_dish_params
  params = [] of String
  params << "product_id=#{side_dish_hash["product_id"]}"
  params << "meal_id=#{side_dish_hash["meal_id"]}"
  params << "unit=#{side_dish_hash["unit"]}"
  params << "amount=#{side_dish_hash["amount"]}"
  params.join("&")
end

def create_side_dish
  model = SideDish.new(side_dish_hash)
  model.save
  model
end

class SideDishControllerTest < GarnetSpec::Controller::Test
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

describe SideDishControllerTest do
  subject = SideDishControllerTest.new

  it "renders side_dish index template" do
    SideDish.clear
    response = subject.get "/side_dishes"

    response.status_code.should eq(200)
    response.body.should contain("side_dishes")
  end

  it "renders side_dish show template" do
    SideDish.clear
    model = create_side_dish
    location = "/side_dishes/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Side Dish")
  end

  it "renders side_dish new template" do
    SideDish.clear
    location = "/side_dishes/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Side Dish")
  end

  it "renders side_dish edit template" do
    SideDish.clear
    model = create_side_dish
    location = "/side_dishes/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Side Dish")
  end

  it "creates a side_dish" do
    SideDish.clear
    response = subject.post "/side_dishes", body: side_dish_params

    response.headers["Location"].should eq "/side_dishes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a side_dish" do
    SideDish.clear
    model = create_side_dish
    response = subject.patch "/side_dishes/#{model.id}", body: side_dish_params

    response.headers["Location"].should eq "/side_dishes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a side_dish" do
    SideDish.clear
    model = create_side_dish
    response = subject.delete "/side_dishes/#{model.id}"

    response.headers["Location"].should eq "/side_dishes"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
