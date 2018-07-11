h1 Show Product Source
p = product_source.name
p = product_source.url
p = product_source.notes
p
  == link_to("back", "/product_sources", class: "btn btn-light btn-sm")
  == link_to("edit", "/product_sources/#{product_source.id}/edit", class: "btn btn-success btn-sm")
  == link_to("delete", "/product_sources/#{product_source.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
