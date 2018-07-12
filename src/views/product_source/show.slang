h1 Show Product Source
p = product_source.name
p = product_source.url
p = product_source.notes
p
  == link_to("back", "/product_sources", class: "btn btn-light btn-sm")
.row
  .col-sm-11
    h2 Products
.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
        th Actions
    tbody
      - product_source.products.each do |product|
        tr
          td = product.name
          td
            span
              == link_to("show","/products/#{product.id}", class: "btn btn-primary btn-sm")
