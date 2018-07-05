- if dish.errors
  ul.errors
    - dish.errors.each do |error|
      li = error.to_s

== form(action: "/meals/#{meal.id}/dishes/#{dish.id.to_s}", method: dish.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:recipe)
    == select_field(name: "recipe_id", collection: Recipe.all.map{|recipe| [recipe.id, recipe.name]}, selected: dish.recipe_id, class: "form-control")
  .form-group
    == label(:serving)
    == text_field(name: "serving", value: 1.0, placeholder: 1.0, class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/meals/#{meal.id}", class: "btn btn-light btn-sm")
