h1 = product.name
p = "Nutrition facts for #{product.amount}#{product.unit}"
p = "Calories: #{"%.2f" % (nutrition_fact.calories || 0.0)}"
p = "Fat: #{"%.2f" % (nutrition_fact.fat || 0.0)}"
p = "Carbohydrate: #{"%.2f" % (nutrition_fact.carbohydrate || 0.0)}"
p = "Protein: #{"%.2f" % (nutrition_fact.protein || 0.0)}"
p
  - if product.product_source_id
    == link_to("back", "/product_sources/#{product.product_source.id}", class: "btn btn-light btn-sm")
  - else
    == link_to("back", "/products", class: "btn btn-light btn-sm")
    == link_to("edit", "/products/#{product.id}/edit", class: "btn btn-success btn-sm")
    == link_to("delete", "/products/#{product.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
