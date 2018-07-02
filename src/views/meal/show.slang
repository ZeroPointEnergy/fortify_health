h1 Show Meal
p = meal.time
p = meal.user.id
p = meal.nutrition_fact.id
p
  == link_to("back", "/meals", class: "btn btn-light btn-sm")
  == link_to("edit", "/meals/#{meal.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/meals/#{meal.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
