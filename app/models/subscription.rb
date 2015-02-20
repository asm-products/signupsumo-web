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

  def stripe_subscription
    @stripe_subscription ||= customer &&
      customer[:subscriptions] &&
      customer[:subscriptions][:data] &&
      Array.wrap(customer[:subscriptions][:data]).find{ |s| s[:status] == 'active' }
  end

  def active?
    stripe_subscription.present?
  end
end
