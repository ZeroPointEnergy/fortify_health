class ProductSourceSubscription < Granite::Base
  adapter pg
  table_name product_source_subscriptions

  belongs_to :user

  belongs_to :product_source

  # id : Int64 primary key is created for you
  timestamps
end
