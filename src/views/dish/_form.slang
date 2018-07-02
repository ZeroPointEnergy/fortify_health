- if dish.errors
  ul.errors
    - dish.errors.each do |error|
      li = error.to_s

== form(action: "/dishes/#{dish.id.to_s}", method: dish.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:recipe)
    == select_field(name: "recipe_id", collection: Recipe.all.map{|recipe| [recipe.id, recipe.id]}, selected: dish.recipe_id, class: "form-control")
  .form-group
    == label(:meal)
    == select_field(name: "meal_id", collection: Meal.all.map{|meal| [meal.id, meal.id]}, selected: dish.meal_id, class: "form-control")
  .form-group
    == label(:nutrition_fact)
    == select_field(name: "nutrition_fact_id", collection: NutritionFact.all.map{|nutrition_fact| [nutrition_fact.id, nutrition_fact.id]}, selected: dish.nutrition_fact_id, class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/dishes", class: "btn btn-light btn-sm")
