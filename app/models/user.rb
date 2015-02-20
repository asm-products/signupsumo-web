class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable

  has_many :signups,
    dependent: :destroy

  has_many :free_signups
  has_many :subscription_signups

  has_one :subscription,
    dependent: :destroy

  validates :email,
    presence: true,
    uniqueness: true

  before_validation :set_authentication_token

  def setup?
    signups.exists?
  end

  def set_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).exists?
    end
  end

  def exhausted_freebies?
    freebie_count <= 0
  end

  def exhausted_subscription?
    subscription.nil? || (
      subscription.active? &&
        subscription_signups.influential.this_month.count >= Subscription::MONTHLY_LIMIT
    )
  end

  def at_signup_limit?
    exhausted_freebies? && exhausted_subscription?
  end
end
