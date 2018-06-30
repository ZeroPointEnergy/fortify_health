- if product.errors
  ul.errors
    - product.errors.each do |error|
      li = error.to_s

== form(action: "/products/#{product.id.to_s}", method: product.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "name", value: product.name, placeholder: "Name", class: "form-control")
  .form-group
    == text_field(name: "unit", value: product.unit, placeholder: "Unit", class: "form-control")
  .form-group
    == text_field(name: "amount", value: product.amount, placeholder: "Amount", class: "form-control")
  .form-group
    == text_field(name: "calories", value: nutrition_fact.calories, placeholder: "Calories", class: "form-control")
  .form-group
    == text_field(name: "fat", value: nutrition_fact.fat, placeholder: "Fat", class: "form-control")
  .form-group
    == text_field(name: "carbohydrate", value: nutrition_fact.carbohydrate, placeholder: "Carbohydrate", class: "form-control")
  .form-group
    == text_field(name: "protein", value: nutrition_fact.protein, placeholder: "Protein", class: "form-control")

  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/products", class: "btn btn-light btn-sm")
