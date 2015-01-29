class ScriptsController < ApplicationController
  respond_to :js
  protect_from_forgery except: :show

  def show
    @api_key = params[:api_key]
  end

  def test
    @api_key = "6b87c6f41586fcb18e08ef638e332a12"
  end
end
