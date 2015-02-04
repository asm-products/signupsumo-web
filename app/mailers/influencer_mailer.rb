class InfluencerMailer < ApplicationMailer
  def influencer_email(user, signup)
    @user = user
    @signup = signup

    mail(to: @user.email, subject: "#{@user.first_name} just signed up!")
  end
end
