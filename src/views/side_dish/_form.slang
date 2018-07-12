- if side_dish.errors
  ul.errors
    - side_dish.errors.each do |error|
      li = error.to_s

== form(action: "/meals/#{meal.id}/side_dishes/#{side_dish.id.to_s}", method: side_dish.id ? :patch : :post) do
  == csrf_tag
  .form-group
    == label(:product)
    select name="product_id" selected="#{side_dish.product_id}" class="form-control selectpicker" data-live-search="true" title="Select a product..."
      - user.products_in_groups.each do |group, products|
        optgroup label="#{group}" data-max-options="2"
          - products.each do |product|
            option value="#{product.id}" #{product.name}
  .form-group
    == text_field(name: "unit", value: side_dish.unit, placeholder: "Unit", class: "form-control")
  .form-group
    == text_field(name: "amount", value: side_dish.amount, placeholder: "Amount", class: "form-control")
  == submit("Submit", class: "btn btn-primary btn-sm")
  == link_to("back", "/meals/#{meal.id}", class: "btn btn-light btn-sm")
