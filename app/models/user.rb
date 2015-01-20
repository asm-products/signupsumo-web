class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :websites, dependent: :delete_all

  validates_uniqueness_of :email
  validates_presence_of :email

end
