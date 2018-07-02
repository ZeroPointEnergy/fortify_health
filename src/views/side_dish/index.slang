.row
  .col-sm-11
    h2 Side Dishes
  .col-sm-1
    a.btn.btn-success.btn-sm href="/side_dishes/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Product
        th Meal
        th Unit
        th Amount
        th Actions
    tbody
      - side_dishes.each do |side_dish|
        tr
          td = side_dish.product.id
          td = side_dish.meal.id
          td = side_dish.unit
          td = side_dish.amount
          td
            span
              == link_to("read", "/side_dishes/#{side_dish.id}", class: "btn btn-primary btn-sm")
              == link_to("edit", "/side_dishes/#{side_dish.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/side_dishes/#{ side_dish.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
