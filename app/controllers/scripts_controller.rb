class ScriptsController < ApplicationController
  respond_to :js
  protect_from_forgery except: :show

  def show
    @api_key = params[:api_key]
  end

  def test; end
end
