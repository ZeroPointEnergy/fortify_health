- if ingrediant.errors
  ul.errors
    - ingrediant.errors.each do |error|
      li = error.to_s

== form(action: "/ingrediants/#{ingrediant.id.to_s}", method: ingrediant.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:recipe)
    == select_field(name: "recipe_id", collection: Recipe.all.map{|recipe| [recipe.id, recipe.id]}, selected: ingrediant.recipe_id, class: "form-control")
  .form-group
    == label(:product)
    == select_field(name: "product_id", collection: Product.all.map{|product| [product.id, product.id]}, selected: ingrediant.product_id, class: "form-control")
  .form-group
    == label(:user)
    == select_field(name: "user_id", collection: User.all.map{|user| [user.id, user.id]}, selected: ingrediant.user_id, class: "form-control")
  .form-group
    == text_field(name: "unit", value: ingrediant.unit, placeholder: "Unit", class: "form-control")
  .form-group
    == text_field(name: "amount", value: ingrediant.amount, placeholder: "Amount", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/ingrediants", class: "btn btn-light btn-sm")
