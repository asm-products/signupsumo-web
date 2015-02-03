class Subscription < ActiveRecord::Base
  attr_accessor :card_token

  belongs_to :user

  before_validation :create_stripe_subscription

  def create_stripe_subscription
    # TODO: Talk to Stripe
  end
end
