class SubscriptionSignup < Signup
  after_create :ensure_subscription_start

private

  def ensure_subscription_start
    self.user.subscription.subscribe_stripe_customer
  end
end
