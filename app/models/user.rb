class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable

  has_many :signups,
    dependent: :destroy

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

  def at_signup_limit?
    count = signups.influential.this_month.count
    count >= signup_limit
  end

  def signup_limit
    if subscription && subscription.active?
      100
    else
      10
    end
  end
end
