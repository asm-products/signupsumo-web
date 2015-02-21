module StripeCustomer
  extend ActiveSupport::Concern

  included do
    before_validation :create_stripe_customer,
      on: :create
  end

  def stripe_customer
    @stripe_customer ||= self.customer && self.customer[:id] &&
      Stripe::Customer.retrieve(self.customer[:id])
  end

  def create_stripe_customer
    return if card_token.blank? || user.blank?

    customer = Stripe::Customer.create(
      card: card_token,
      email: user.email
    )

    self.customer = customer.as_json
  end

  def subscribe_stripe_customer
    if !active? && stripe_customer
      stripe_customer.subscriptions.create({:plan => Subscription::PLAN})
      refresh_stripe_customer
    end
  end

  def refresh_stripe_customer
    @stripe_customer = nil
    if stripe_customer
      self.customer = stripe_customer.as_json
      save
    end
  end
end
