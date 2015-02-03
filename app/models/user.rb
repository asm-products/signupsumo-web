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

  def set_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).exists?
    end
  end
end
