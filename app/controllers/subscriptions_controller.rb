class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @subscription = current_user.subscription || Subscription.new
  end

  def create
    subscription_params = params[:subscription]
    token = subscription_params && subscription_params[:card_token]

    @subscription = Subscription.new(card_token: token, user_id: current_user.id)

    if @subscription.save
      flash[:thanks] = true
      redirect_to dashboard_index_path
    else
      render 'show'
    end
  end

  def subscription_create_params
    params.require(:subscription).
      permit(:card_token).
      merge(user_id: current_user.id)
  end
end
