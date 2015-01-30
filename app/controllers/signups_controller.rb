class SignupsController < ApplicationController
  def create
    user = User.find_by(authentication_token: params[:token])

    render json: { response: 'Bad request' } and return unless user

    ChecksInfluence.perform_later(user, params[:email])

    render json: { response: 'Submitted successfully' }
  end
end
