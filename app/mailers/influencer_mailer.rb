class InfluencerMailer < ApplicationMailer
  def influencer_email(user, influencer)
    @user = user
    @influencer = influencer

    mail(to: @user.email, subject: 'Someone signed up!')
  end
end
