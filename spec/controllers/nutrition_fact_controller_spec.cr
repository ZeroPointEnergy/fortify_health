require "./spec_helper"

def nutrition_fact_hash
  {"calories" => "1", "fat" => "1", "carbohydrate" => "1", "protein" => "1"}
end

def nutrition_fact_params
  params = [] of String
  params << "calories=#{nutrition_fact_hash["calories"]}"
  params << "fat=#{nutrition_fact_hash["fat"]}"
  params << "carbohydrate=#{nutrition_fact_hash["carbohydrate"]}"
  params << "protein=#{nutrition_fact_hash["protein"]}"
  params.join("&")
end

def create_nutrition_fact
  model = NutritionFact.new(nutrition_fact_hash)
  model.save
  model
end

class NutritionFactControllerTest < GarnetSpec::Controller::Test
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

describe NutritionFactControllerTest do
  subject = NutritionFactControllerTest.new

  it "renders nutrition_fact index template" do
    NutritionFact.clear
    response = subject.get "/nutrition_facts"

    response.status_code.should eq(200)
    response.body.should contain("nutrition_facts")
  end

  it "renders nutrition_fact show template" do
    NutritionFact.clear
    model = create_nutrition_fact
    location = "/nutrition_facts/#{model.id}"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Show Nutrition Fact")
  end

  it "renders nutrition_fact new template" do
    NutritionFact.clear
    location = "/nutrition_facts/new"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("New Nutrition Fact")
  end

  it "renders nutrition_fact edit template" do
    NutritionFact.clear
    model = create_nutrition_fact
    location = "/nutrition_facts/#{model.id}/edit"

    response = subject.get location

    response.status_code.should eq(200)
    response.body.should contain("Edit Nutrition Fact")
  end

  it "creates a nutrition_fact" do
    NutritionFact.clear
    response = subject.post "/nutrition_facts", body: nutrition_fact_params

    response.headers["Location"].should eq "/nutrition_facts"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "updates a nutrition_fact" do
    NutritionFact.clear
    model = create_nutrition_fact
    response = subject.patch "/nutrition_facts/#{model.id}", body: nutrition_fact_params

    response.headers["Location"].should eq "/nutrition_facts"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end

  it "deletes a nutrition_fact" do
    NutritionFact.clear
    model = create_nutrition_fact
    response = subject.delete "/nutrition_facts/#{model.id}"

    response.headers["Location"].should eq "/nutrition_facts"
    response.status_code.should eq(302)
    response.body.should eq "302"
  end
end
