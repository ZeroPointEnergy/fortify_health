.row
  .col-sm-11
    h2 Recipes
  .col-sm-1
    a.btn.btn-success.btn-sm href="/recipes/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
        th Created
        th Updated
        th Actions
    tbody
      - recipes.each do |recipe|
        tr
          td = recipe.name
          td = recipe.created_at
          td = recipe.updated_at
          td
            span
              == link_to("edit", "/recipes/#{recipe.id}", class: "btn btn-primary btn-sm")
              == link_to("rename", "/recipes/#{recipe.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/recipes/#{ recipe.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
