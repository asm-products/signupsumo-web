class Profile < ActiveRecord::Base
  
  has_many :registers
  has_many :websites, :through => :registers

  validates_presence_of :email

end
