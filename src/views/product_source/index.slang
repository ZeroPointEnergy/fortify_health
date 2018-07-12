.row
  .col-sm-11
    h2 Product Sources
.table-responsive
  table.table.table-striped
    thead
      tr
        th Name
        th Url
        th Notes
    tbody
      - user.product_sources_with_subscription.each do |product_source, subscription|
        tr
          td = product_source.name
          td = product_source.url
          td = product_source.notes
          td
            span
              == link_to("info", "/product_sources/#{product_source.id}", class: "btn btn-primary btn-sm")
          td
            span
              - if subscription
                == link_to("unsubscribe", "/product_sources/#{product_source.id}/subscriptions/#{subscription.id}?_csrf=#{csrf_token}", "data-method": "delete", "data-confirm": "Are you sure?", class: "btn btn-danger btn-sm")
              - else
                == button_to("subscribe", "/product_sources/#{product_source.id}/subscriptions?_csrf=#{csrf_token}", :post, class: "btn btn-success btn-sm btn-mini"){}
