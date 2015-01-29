class RegistersController < ApplicationController
  include ProfileHelper
  include WebsitesHelper

  before_action :verify_website, :set_profile, only: [:create]
  before_action :set_website, only: [:index]
  
  def create
    if @website
      if @website.registers.find_by_profile_id(@profile)
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

  def index
    @registers = @website.registers.all
  end

  private
    def verify_website
      host = check_url(params[:url])
      @website = Website.find_by_secret_token_and_host(params[:token],host)
    end

    def set_profile
      @profile = find_profile(params[:email])
    end

    def set_website
      @website = Website.find_by_id(params[:id])
    end
end
