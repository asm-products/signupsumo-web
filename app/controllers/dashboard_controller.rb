class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @influencers = current_user.signups.influential.visible
  end
end
