.row
  .col-sm-11
    h2 Meals
  .col-sm-1
    a.btn.btn-success.btn-sm href="/meals/new" New
- user.meals_by_days.each do |day, meals|
  h3 == day
  .table-responsive
    table.table.table-striped
      thead
        tr
          th Time
          th Calories
          th Actions
      tbody
        - meals.each do |meal|
          tr
            td = meal.time
            td = meal.nutrition_fact.calories
            td
              span
                == link_to("edit meal", "/meals/#{meal.id}", class: "btn btn-primary btn-sm")
                == link_to("edit time", "/meals/#{meal.id}/edit", class: "btn btn-success btn-sm")
                == link_to("delete", "/meals/#{ meal.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
