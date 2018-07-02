- if ingrediant.errors
  ul.errors
    - ingrediant.errors.each do |error|
      li = error.to_s

== form(action: "/recipes/#{recipe.id.to_s}/ingrediants/#{ingrediant.id.to_s}", method: ingrediant.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:product)
    == select_field(name: "product_id", collection: Product.all.map{|product| [product.id, product.name]}, selected: ingrediant.product_id, class: "form-control")
  .form-group
    == text_field(name: "unit", value: ingrediant.unit, placeholder: "Unit", class: "form-control")
  .form-group
    == text_field(name: "amount", value: ingrediant.amount, placeholder: "Amount", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/recipes/#{recipe.id}", class: "btn btn-light btn-sm")
