class Subscription < ActiveRecord::Base
  PLAN = '100_monthly'
  MONTHLY_LIMIT = 100

  include StripeCustomer

  attr_accessor :card_token

  belongs_to :user

  validates :customer,
    presence: true

  validates :user_id,
    presence: true

  def customer
    super && super.deep_symbolize_keys
  end

  def active_stripe_subscription
    @active_stripe_subscription ||= stripe_subscriptions.find do |s|
       Time.now < Time.at(s[:current_period_end]) && s[:status] == 'active'
    end
  end

  def stripe_subscriptions
    (
      customer &&
        customer[:subscriptions] &&
        Array.wrap(customer[:subscriptions][:data])
    ) || []
  end

  def active?
    active_stripe_subscription.present?
  end

  def needs_info?
    stripe_customer.nil? || (stripe_subscriptions.present? && !active?)
  end
end
