class ChecksInfluenceJob < ActiveJob::Base
  MIN_INFLUENCER_SCORE = 0.75

  queue_as :default

  def perform(user, email)
    signup = Clearbit::LeadScore.lookup(email)
    return unless signup && signup.baller?

    InfluencerMailer.influencer_email(user, signup).deliver

    # Record infleunce in db or at least a record of the email
  end
end
