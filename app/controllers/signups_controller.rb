class SignupsController < ApplicationController
  def create
    user = User.find_by(authentication_token: params[:token])

    ChecksInfluence.perform_later(user, params[:email]) if user

    if user
      render json: { response: 'Submitted successfully' }
    else
      # TODO: return more specific errors for the user here
      render json: { response: 'Bad request' }
    end
  end
end
