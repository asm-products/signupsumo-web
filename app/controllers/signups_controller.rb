class SignupsController < ApplicationController
  # TODO: Rework this so it just kicks off a background job
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
end
