.row
  .col-sm-11
    h2 Meals
  .col-sm-1
    a.btn.btn-success.btn-sm href="/meals/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Time
        th User
        th Nutrition_fact
        th Actions
    tbody
      - meals.each do |meal|
        tr
          td = meal.time
          td = meal.user.id
          td = meal.nutrition_fact.id
          td
            span
              == link_to("read", "/meals/#{meal.id}", class: "btn btn-primary btn-sm")
              == link_to("edit", "/meals/#{meal.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/meals/#{ meal.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
