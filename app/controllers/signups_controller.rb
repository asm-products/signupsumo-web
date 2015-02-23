class SignupsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(authentication_token: token)

    render json: { response: 'Bad request' }, status: :bad_request and return unless user

    ChecksInfluenceJob.perform_later(user, email)

    render json: { response: 'Submitted successfully' }
  end

private

  def token
    params.require(:token)
  end

  def email
    params.require(:email)
  end
end
