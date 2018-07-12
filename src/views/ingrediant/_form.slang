- if ingrediant.errors
  ul.errors
    - ingrediant.errors.each do |error|
      li = error.to_s

== form(action: "/recipes/#{recipe.id.to_s}/ingrediants/#{ingrediant.id.to_s}", method: ingrediant.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:product)
    select name="product_id" selected="#{ingrediant.product_id}" class="form-control selectpicker" data-live-search="true" title="Select a product..."
      - user.products_in_groups.each do |group, products|
        optgroup label="#{group}" data-max-options="2"
          - products.each do |product|
            option value="#{product.id}" #{product.name}
  .form-group
    == text_field(name: "unit", value: ingrediant.unit, placeholder: "Unit", class: "form-control")
  .form-group
    == text_field(name: "amount", value: ingrediant.amount, placeholder: "Amount", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/recipes/#{recipe.id}", class: "btn btn-light btn-sm")
