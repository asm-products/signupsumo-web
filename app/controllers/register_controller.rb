class RegisterController < ApplicationController
  include ProfileHelper
  include WebsitesHelper

  before_action :set_website, :set_profile, only: [:create]
  
  def create
    if @website
      if @website.registers.find(@profile)
        response = "Already Registered"
      else
        @register = @website.registers.create(is_influential: @profile.is_influential, profile: @profile)
        response = "Registered Successfully"
      end
    else
      response = "BAD REQUEST"
    end

    render json: {response: response}
    return 
  end

  private
    def set_website
      host = check_url(params[:url])
      @website = Website.find_by_secret_token_and_host(params[:token],host)
    end

    def set_profile
      @profile = find_profile(params[:email])
    end
end
