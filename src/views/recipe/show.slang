h1 = "Recipe for #{recipe.name}"
p
  == link_to("back", "/recipes", class: "btn btn-light btn-sm")
  == link_to("rename", "/recipes/#{recipe.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/recipes/#{recipe.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
p
h2 Nutrition Facts
p = "Calories: #{"%.2f" % (recipe.nutrition_fact.calories || 0.0)}"
p = "Fat: #{"%.2f" % (recipe.nutrition_fact.fat || 0.0)}"
p = "Carbohydrate: #{"%.2f" % (recipe.nutrition_fact.carbohydrate || 0.0)}"
p = "Protein: #{"%.2f" % (recipe.nutrition_fact.protein || 0.0)}"
.row
  .col-sm-11
    h2 Ingrediants
  .col-sm-1
    a.btn.btn-success.btn-sm href="/recipes/#{recipe.id}/ingrediants/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Product
        th Amount
        th Actions
    tbody
      - recipe.ingrediants.each do |ingrediant|
        tr
          td = ingrediant.product.name
          td = "#{ingrediant.amount}#{ingrediant.unit}"
          td
            span
              == link_to("edit", "/recipes/#{recipe.id}/ingrediants/#{ingrediant.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/recipes/#{recipe.id}/ingrediants/#{ ingrediant.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
