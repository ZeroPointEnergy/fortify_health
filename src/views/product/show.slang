h1 Show Product
p = product.name
p = product.unit
p = product.amount
p = nutrition_fact.calories
p = nutrition_fact.fat
p = nutrition_fact.carbohydrate
p = nutrition_fact.protein
p
  == link_to("back", "/products", class: "btn btn-light btn-sm")
  == link_to("edit", "/products/#{product.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/products/#{product.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
