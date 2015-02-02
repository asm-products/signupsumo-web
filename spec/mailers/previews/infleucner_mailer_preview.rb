class InfluencerMailerPreview < ActionMailer::Preview
  def influencer_email
    user = User.first!
    signup = Signup.where(influential: true).first!
    InfluencerMailer.influencer_email(user, signup)
  end
end
