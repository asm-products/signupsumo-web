class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @influencers = current_user.signups.where(influential: true)
  end
end
