class Subscription < ActiveRecord::Base
  PLAN = '100_monthly'

  attr_accessor :card_token

  belongs_to :user

  before_validation :create_stripe_subscription,
    on: :create

  validates :customer,
    presence: true

  validates :user_id,
    presence: true

  def customer
    super && super.deep_symbolize_keys
  end

  def create_stripe_subscription
    return if card_token.blank? || user.blank?

    customer = Stripe::Customer.create(
      card: card_token,
      plan: PLAN,
      email: user.email
    )

    period_end = customer.subscriptions.data.find do |subscription|
      subscription.status == "active"
    end.current_period_end

    self.customer = customer.as_json
    self.active_until = Time.at(period_end)
  end

  def active?
    active_until.present? && active_until.future?
  end
end
