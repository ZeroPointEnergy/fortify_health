.row
  .col-sm-11
    h2 Dishes
  .col-sm-1
    a.btn.btn-success.btn-sm href="/dishes/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Recipe
        th Meal
        th Nutrition_fact
        th Actions
    tbody
      - dishes.each do |dish|
        tr
          td = dish.recipe.id
          td = dish.meal.id
          td = dish.nutrition_fact.id
          td
            span
              == link_to("read", "/dishes/#{dish.id}", class: "btn btn-primary btn-sm")
              == link_to("edit", "/dishes/#{dish.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/dishes/#{ dish.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
