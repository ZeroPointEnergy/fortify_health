h1 Show Ingrediant
p = ingrediant.recipe.id
p = ingrediant.product.id
p = ingrediant.user.id
p = ingrediant.unit
p = ingrediant.amount
p
  == link_to("back", "/ingrediants", class: "btn btn-light btn-sm")
  == link_to("edit", "/ingrediants/#{ingrediant.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/ingrediants/#{ingrediant.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
