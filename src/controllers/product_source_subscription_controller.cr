class ProductSourceSubscriptionController < ApplicationController
  def create
    user = get_user
    product_source = resolve(params["product_source_id"], ProductSource)
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
    product_source = resolve(params["product_source_id"], ProductSource)
    if subscription = ProductSourceSubscription.find(params["id"])
      if subscription.user == user
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

end
