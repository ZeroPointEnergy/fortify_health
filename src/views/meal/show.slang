h1 = "Meal for #{meal.time}"
p
  == link_to("back", "/meals", class: "btn btn-light btn-sm")
  == link_to("edit time", "/meals/#{meal.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/meals/#{meal.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
p
h2 Nutrition Facts
p = "Calories: #{meal.nutrition_fact.calories}"
p = "Fat: #{meal.nutrition_fact.fat}"
p = "Carbohydrate: #{meal.nutrition_fact.carbohydrate}"
p = "Protein: #{meal.nutrition_fact.protein}"
.row
  .col-sm-11
    h2 Dishes
  .col-sm-1
    a.btn.btn-success.btn-sm href="/meals/#{meal.id}/dishes/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Recipe
        th Calories
        th Actions
    tbody
      - meal.dishes.each do |dish|
        tr
          td = dish.recipe.name
          td = dish.nutrition_fact.calories
          td
            span
              == link_to("delete", "/meals/#{meal.id}/dishes/#{ dish.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
.row
  .col-sm-11
    h2 Side Dishes
  .col-sm-1
    a.btn.btn-success.btn-sm href="/meals/#{meal.id}/side_dishes/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Product
        th Amount
        th Actions
    tbody
      - meal.side_dishes.each do |side_dish|
        tr
          td = side_dish.product.name
          td = "#{side_dish.amount}#{side_dish.unit}"
          td
            span
              == link_to("edit", "/meals/#{meal.id}/side_dishes/#{side_dish.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/meals/#{meal.id}/side_dishes/#{ side_dish.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
