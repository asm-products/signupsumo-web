class SubscriptionsController < ApplicationController
  def show
    @subscription = current_user.subscription
    @subscription ||= Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_create_params)

    if @subscription.save
      redirect_to :show
    else
      render :show
    end
  end

  def subscription_create_params
    params.require(:subscription).
      permit(:card_token)
  end
end
