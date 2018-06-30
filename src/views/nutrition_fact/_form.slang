- if nutrition_fact.errors
  ul.errors
    - nutrition_fact.errors.each do |error|
      li = error.to_s

== form(action: "/nutrition_facts/#{nutrition_fact.id.to_s}", method: nutrition_fact.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "calories", value: nutrition_fact.calories, placeholder: "Calories", class: "form-control")
  .form-group
    == text_field(name: "fat", value: nutrition_fact.fat, placeholder: "Fat", class: "form-control")
  .form-group
    == text_field(name: "carbohydrate", value: nutrition_fact.carbohydrate, placeholder: "Carbohydrate", class: "form-control")
  .form-group
    == text_field(name: "protein", value: nutrition_fact.protein, placeholder: "Protein", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/nutrition_facts", class: "btn btn-light btn-sm")
