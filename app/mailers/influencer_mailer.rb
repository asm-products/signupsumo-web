class InfluencerMailer < ApplicationMailer
  def influencer_email(user, signup)
    @user = user
    @signup = signup

    mail(to: @user.email, subject: 'Someone signed up!')
  end
end
