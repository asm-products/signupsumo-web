class RefreshStripeCustomer < ActiveJob::Base

  def perform(subscription)
    subscription.refresh_stripe_customer
  end
end
