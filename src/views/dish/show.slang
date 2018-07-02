h1 Show Dish
p = dish.recipe.id
p = dish.meal.id
p = dish.nutrition_fact.id
p
  == link_to("back", "/dishes", class: "btn btn-light btn-sm")
  == link_to("edit", "/dishes/#{dish.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/dishes/#{dish.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
