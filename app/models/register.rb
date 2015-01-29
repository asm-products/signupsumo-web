class Register < ActiveRecord::Base

  belongs_to :website
  belongs_to :profile

  validates :website_id, :profile_id, :presence => true
  
end
