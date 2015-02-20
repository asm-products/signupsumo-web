class Subscription < ActiveRecord::Base
  PLAN = '100_monthly'
  MONTHLY_LIMIT = 100

  attr_accessor :card_token

  belongs_to :user

  before_validation :create_stripe_customer,
    on: :create

  validates :customer,
    presence: true

  validates :user_id,
    presence: true

  def customer
    super && super.deep_symbolize_keys
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
    if customer = Stripe::Customer.retrieve(customer[:id])
      customer.subscriptions.create({:plan => PLAN})
      refresh_stripe_customer
    end
  end

  def refresh_stripe_customer
    if customer = Stripe::Customer.retrieve(customer[:id])
      self.customer = customer.as_json
      save
    end
  end

  def active?
    customer &&
      customer[:subscriptions] &&
      customer[:subscriptions][:data] &&
      Array.wrap(customer[:subscriptions][:data]).find{ |s| s[:status] == 'active' }
  end
end
