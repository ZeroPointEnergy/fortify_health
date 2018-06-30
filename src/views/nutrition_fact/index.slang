.row
  .col-sm-11
    h2 Nutrition Facts
  .col-sm-1
    a.btn.btn-success.btn-sm href="/nutrition_facts/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Calories
        th Fat
        th Carbohydrate
        th Protein
        th Actions
    tbody
      - nutrition_facts.each do |nutrition_fact|
        tr
          td = nutrition_fact.calories
          td = nutrition_fact.fat
          td = nutrition_fact.carbohydrate
          td = nutrition_fact.protein
          td
            span
              == link_to("read", "/nutrition_facts/#{nutrition_fact.id}", class: "btn btn-primary btn-sm")
              == link_to("edit", "/nutrition_facts/#{nutrition_fact.id}/edit", class: "btn btn-success btn-sm")
              == link_to("delete", "/nutrition_facts/#{ nutrition_fact.id }?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
