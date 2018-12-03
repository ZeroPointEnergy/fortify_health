class ProductSourceSubscription < Granite::Base
  adapter pg
  table_name product_source_subscriptions

  belongs_to :user, class_name: User
  belongs_to :product_source, class_name: ProductSource

  # id : Int64 primary key is created for you
  timestamps
end
