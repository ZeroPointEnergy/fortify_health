- if product.errors
  ul.errors
    - product.errors.each do |error|
      li = error.to_s

== form(action: "/products/#{product.id.to_s}", method: product.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == text_field(name: "name", value: product.name, placeholder: "Name", class: "form-control")
  .form-group
    == label(:user)
    == select_field(name: "user_id", collection: User.all.map{|user| [user.id, user.id]}, selected: product.user_id, class: "form-control")
  .form-group
    == text_field(name: "unit", value: product.unit, placeholder: "Unit", class: "form-control")
  .form-group
    == text_field(name: "amount", value: product.amount, placeholder: "Amount", class: "form-control")
  .form-group
    == label(:nutrition_fact)
    == select_field(name: "nutrition_fact_id", collection: NutritionFact.all.map{|nutrition_fact| [nutrition_fact.id, nutrition_fact.id]}, selected: product.nutrition_fact_id, class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/products", class: "btn btn-light btn-sm")
