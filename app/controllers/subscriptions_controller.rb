class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:stripe_hook]
  protect_from_forgery except: :stripe_hook

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

  def stripe_hook
    if customer_id = params.try(:[], 'data').try(:[], 'object').try(:[], 'customer')
      if subscription = Subscription.where("customer->>'id' = ?", customer_id).first
        case params['type']
        when 'invoice.payment_succeeded'
          RefreshStripeCustomer.perform_later(subscription)
        when 'invoice.payment_failed'
          NotifyPaymentFailure.perform_later(subscription)
        end
      end
    end

    render nothing: true
  end

private

  def subscription_create_params
    params.require(:subscription).
      permit(:card_token).
      merge(user_id: current_user.id)
  end
end
