class Website < ActiveRecord::Base

  belongs_to :user
  has_many :registers, dependent: :delete_all
  has_many :profiles, :through => :registers

  validates :user_id, :name, :host, :secret_token, :presence => true
  
end
