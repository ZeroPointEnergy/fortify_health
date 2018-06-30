class NutritionFactController < ApplicationController
  def index
    nutrition_facts = NutritionFact.all
    render("index.slang")
  end

  def show
    if nutrition_fact = NutritionFact.find params["id"]
      render("show.slang")
    else
      flash["warning"] = "NutritionFact with ID #{params["id"]} Not Found"
      redirect_to "/nutrition_facts"
    end
  end

  def new
    nutrition_fact = NutritionFact.new
    render("new.slang")
  end

  def create
    nutrition_fact = NutritionFact.new(nutrition_fact_params.validate!)

    if nutrition_fact.valid? && nutrition_fact.save
      flash["success"] = "Created NutritionFact successfully."
      redirect_to "/nutrition_facts"
    else
      flash["danger"] = "Could not create NutritionFact!"
      render("new.slang")
    end
  end

  def edit
    if nutrition_fact = NutritionFact.find params["id"]
      render("edit.slang")
    else
      flash["warning"] = "NutritionFact with ID #{params["id"]} Not Found"
      redirect_to "/nutrition_facts"
    end
  end

  def update
    if nutrition_fact = NutritionFact.find(params["id"])
      nutrition_fact.set_attributes(nutrition_fact_params.validate!)
      if nutrition_fact.valid? && nutrition_fact.save
        flash["success"] = "Updated NutritionFact successfully."
        redirect_to "/nutrition_facts"
      else
        flash["danger"] = "Could not update NutritionFact!"
        render("edit.slang")
      end
    else
      flash["warning"] = "NutritionFact with ID #{params["id"]} Not Found"
      redirect_to "/nutrition_facts"
    end
  end

  def destroy
    if nutrition_fact = NutritionFact.find params["id"]
      nutrition_fact.destroy
    else
      flash["warning"] = "NutritionFact with ID #{params["id"]} Not Found"
    end
    redirect_to "/nutrition_facts"
  end

  def nutrition_fact_params
    params.validation do
      required(:calories) { |f| !f.nil? }
      required(:fat) { |f| !f.nil? }
      required(:carbohydrate) { |f| !f.nil? }
      required(:protein) { |f| !f.nil? }
    end
  end
end
