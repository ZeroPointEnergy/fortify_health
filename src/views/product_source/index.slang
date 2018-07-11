.row
  .col-sm-11
    h2 Product Sources
  .col-sm-1
    a.btn.btn-success.btn-sm href="/product_sources/new" New
.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
        th Url
        th Notes
        th Actions
    tbody
      - user.product_sources_with_subscription_status.each do |product_source, subscribed|
        tr
          td = product_source.name
          td = product_source.url
          td = product_source.notes
          td
            span
              == link_to("info", "/product_sources/#{product_source.id}", class: "btn btn-primary btn-sm")
              - if subscribed
                == link_to("subscribe", "/product_sources/#{product_source.id}/subscribtion", class: "btn btn-success btn-sm")
              - else
                == link_to("unsubscribe", "/product_sources/#{ product_source.id }/subscription?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
