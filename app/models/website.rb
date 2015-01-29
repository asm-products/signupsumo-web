class Website < ActiveRecord::Base
  include WebsitesHelper

  belongs_to :user
  has_many :registers, dependent: :delete_all
  has_many :profiles, :through => :registers

  validates :user_id, :name, :host, :secret_token, :presence => true

  before_validation :format_url, :generate_token

  private

    def format_url
      self.host = check_url(self.host)
    end

    def generate_token
      self[:secret_token] = SecureRandom.hex
    end
  
end
