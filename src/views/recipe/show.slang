h1 Show Recipe
p = recipe.name
p = recipe.user.id
p
  == link_to("back", "/recipes", class: "btn btn-light btn-sm")
  == link_to("edit", "/recipes/#{recipe.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/recipes/#{recipe.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
