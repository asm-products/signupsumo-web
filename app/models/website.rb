class Website < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :name, :host, :secret_token, :presence => true
end
