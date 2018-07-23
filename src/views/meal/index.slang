.row
  .col-sm-11
    h2 Meals
  .col-sm-1
    a.btn.btn-success.btn-sm href="/meals/new" New
- days.each do |_, day|
  h3 == day.date
  h4 Nutrition Facts
  p = "Calories: #{"%.2f" % (day.nutrition_fact.calories || 0.0)}"
  p = "Fat: #{"%.2f" % (day.nutrition_fact.fat || 0.0)}"
  p = "Carbohydrate: #{"%.2f" % (day.nutrition_fact.carbohydrate || 0.0)}"
  p = "Protein: #{"%.2f" % (day.nutrition_fact.protein || 0.0)}"
  .table-responsive
    table.table.table-striped
      thead
        tr
          th Time
          th Calories
          th Actions
      tbody
        - day.meals.each do |meal|
          tr
            td = user.format_time(meal.time)
            td = "%.2f" % (meal.nutrition_fact.calories || 0.0)
            td
              span
                == link_to("edit meal", "/meals/#{meal.id}", class: "btn btn-primary btn-sm")
                == link_to("edit time", "/meals/#{meal.id}/edit", class: "btn btn-success btn-sm")
                == link_to("delete", "/meals/#{ meal.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
