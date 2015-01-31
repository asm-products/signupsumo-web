class ChecksInfluenceJob < ActiveJob::Base
  THRESHOLD = 0.7

  queue_as :default

  def perform(user, email)
    return if !user || user.signups.where(email: email).exists?

    data = Clearbit::LeadScore.lookup(email)
    score = data && data.score || 0
    influential = data > THRESHOLD

    signup = Signup.create!(
      user: user,
      email: email,
      influential: influential,
      data: signup
    )

    InfluencerMailer.influencer_email(user, signup).deliver_now if influential
  end
end
