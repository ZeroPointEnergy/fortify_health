h1 = product.name
p = "Nutrition facts for #{product.amount}#{product.unit}"
p = "Calories: #{nutrition_fact.calories}"
p = "Fat: #{nutrition_fact.fat}"
p = "Carbohydrate: #{nutrition_fact.carbohydrate}"
p = "Protein: #{nutrition_fact.protein}"
p
  - if product.product_source_id
    == link_to("back", "/product_sources/#{product.product_source.id}", class: "btn btn-light btn-sm")
  - else
    == link_to("back", "/products", class: "btn btn-light btn-sm")
    == link_to("edit", "/products/#{product.id}/edit", class: "btn btn-success btn-sm")
    == link_to("delete", "/products/#{product.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
