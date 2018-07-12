class ProductSourceSubscriptionController < ApplicationController
  def create
    user = get_user
    product_source = resolve(subscription_params["product_source_id"], ProductSource)
    subscription = ProductSourceSubscription.new
    subscription.product_source = product_source
    subscription.user = user
    if subscription.valid? && subscription.save
      flash["success"] = "Successfully subscribed to #{product_source.name}"
    else
      flash["danger"] = "Could not subscribe to #{product_source.name}"
    end
    redirect_to "/product_sources"
  end

  def destroy
    user = get_user
    product_source = resolve(subscription_params["product_source_id"], ProductSource)
    if subscription = ProductSourceSubscription.find(params["id"])
      if subscription.user_id == user.id
        subscription.destroy
        flash["success"] = "Successfully unsubscribed from #{product_source.name}"
      else
        flash["danger"] = "Could not unsubs"
      end
    else
      flash["danger"] = "Could not unsubscribe from #{product_source.name}"
    end
    redirect_to "/product_sources"
  end

  def subscription_params
    params.validation do
      required(:product_source_id) { |f| !f.nil? }
    end
  end
end
