class Signup < ActiveRecord::Base
  belongs_to :user

  validates :email,
    presence: true,
    uniqueness: { scope: :user_id }

  validates :user_id,
    presence: true
end
