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
    subscribe_stripe_customer if self.user.exhausted_freebies?
  end

  def subscribe_stripe_customer
    if !active? && (customer = Stripe::Customer.retrieve(self.customer[:id]))
      customer.subscriptions.create({:plan => PLAN})
      refresh_stripe_customer
    end
  end

  def refresh_stripe_customer
    if customer = Stripe::Customer.retrieve(self.customer[:id])
      self.customer = customer.as_json
      self.user.active_until = Time.at(stripe_subscription[:current_period_end])
      self.user.save
      save
    end
  end
end
