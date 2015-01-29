class ChecksInfluenceJob < ActiveJob::Base
  MIN_INFLUENCER_SCORE = 0.75

  queue_as :default

  def perform(email)
    result = Clearbit::LeadScore.lookup(email)
    return unless result && result.baller?

    # Send email or bail
    # Record infleunce in db or at least a record of the email
  end
end
