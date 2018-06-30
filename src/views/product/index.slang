.row
  .col-sm-11
    h2 Products
  .col-sm-1
    a.btn.btn-success.btn-sm href="/products/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
        th User
        th Unit
        th Amount
        th Nutrition_fact
        th Actions
    tbody
      - products.each do |product|
        tr
          td = product.name
          td = product.user.id
          td = product.unit
          td = product.amount
          td = product.nutrition_fact.id
          td
            span
              == link_to("read", "/products/#{product.id}", class: "btn btn-primary btn-sm")
              == link_to("edit", "/products/#{product.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/products/#{ product.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
