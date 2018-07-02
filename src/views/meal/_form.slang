- if meal.errors
  ul.errors
    - meal.errors.each do |error|
      li = error.to_s

== form(action: "/meals/#{meal.id.to_s}", method: meal.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "time", value: meal.time, placeholder: "Time", class: "form-control")
  .form-group
    == label(:user)
    == select_field(name: "user_id", collection: User.all.map{|user| [user.id, user.id]}, selected: meal.user_id, class: "form-control")
  .form-group
    == label(:nutrition_fact)
    == select_field(name: "nutrition_fact_id", collection: NutritionFact.all.map{|nutrition_fact| [nutrition_fact.id, nutrition_fact.id]}, selected: meal.nutrition_fact_id, class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/meals", class: "btn btn-light btn-sm")
