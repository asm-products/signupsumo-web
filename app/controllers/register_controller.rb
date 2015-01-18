class RegisterController < ApplicationController
  include ProfileHelper

  before_action :set_website, :set_profile, only: [:create]
  
  def create
    if @website
      @register = @website.registers.create(is_influential: @profile.is_influential, profile: @profile)
      response = "Registered Successfully"
    else
      response = "BAD REQUEST"
    end

    render json: {response: response}
    return 
  end

  private
    def set_website
      uri = URI(params[:url])
      host = uri.host
      @website = Website.find_by_secret_token_and_host(params[:token],host)
    end

    def set_profile
      @profile = find_profile(params[:email])
    end
end
