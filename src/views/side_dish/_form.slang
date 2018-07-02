- if side_dish.errors
  ul.errors
    - side_dish.errors.each do |error|
      li = error.to_s

== form(action: "/side_dishes/#{side_dish.id.to_s}", method: side_dish.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:product)
    == select_field(name: "product_id", collection: Product.all.map{|product| [product.id, product.id]}, selected: side_dish.product_id, class: "form-control")
  .form-group
    == label(:meal)
    == select_field(name: "meal_id", collection: Meal.all.map{|meal| [meal.id, meal.id]}, selected: side_dish.meal_id, class: "form-control")
  .form-group
    == text_field(name: "unit", value: side_dish.unit, placeholder: "Unit", class: "form-control")
  .form-group
    == text_field(name: "amount", value: side_dish.amount, placeholder: "Amount", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/side_dishes", class: "btn btn-light btn-sm")
