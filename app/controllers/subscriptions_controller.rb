class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, except: [:webhook]
  protect_from_forgery except: :webhook

  def show
    @subscription = current_user.subscription
    @subscription ||= Subscription.new
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

  def webhook
    event_json = JSON.parse(request.body.read)
    event = Stripe::Event.retrieve(event_json["id"])

    if event.type == "invoice.payment_succeeded"
      data = event.data.object
      customer_id = data.customer
      event_subscription = data.lines.subscriptions.first
      period_end = Time.at(event_subscription.period.end)

      subscription = Subscription.where("customer->>'id' = ?", customer_id).first
      subscription.update_attributes(active_until: period_end) if subscription
    end

    render nothing: true, status: 200
  end

  def subscription_create_params
    params.require(:subscription).
      permit(:card_token).
      merge(user_id: current_user.id)
  end
end
