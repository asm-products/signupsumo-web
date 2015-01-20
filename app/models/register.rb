class Register < ActiveRecord::Base

  belongs_to :website
  belongs_to :profile
  
end
