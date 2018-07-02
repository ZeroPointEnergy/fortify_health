h1 Show Side Dish
p = side_dish.product.id
p = side_dish.meal.id
p = side_dish.unit
p = side_dish.amount
p
  == link_to("back", "/side_dishes", class: "btn btn-light btn-sm")
  == link_to("edit", "/side_dishes/#{side_dish.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/side_dishes/#{side_dish.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
