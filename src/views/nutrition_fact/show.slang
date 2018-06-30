h1 Show Nutrition Fact
p = nutrition_fact.calories
p = nutrition_fact.fat
p = nutrition_fact.carbohydrate
p = nutrition_fact.protein
p
  == link_to("back", "/nutrition_facts", class: "btn btn-light btn-sm")
  == link_to("edit", "/nutrition_facts/#{nutrition_fact.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/nutrition_facts/#{nutrition_fact.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
