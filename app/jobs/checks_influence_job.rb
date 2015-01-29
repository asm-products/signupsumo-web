class ChecksInfluenceJob < ActiveJob::Base
  queue_as :default

  def perform(email)
    # 1. Get user data from Clearbit
    # 2. Determine if influential
    # 3. Send email or bail
    # 4. Record infleunce in db or at least a record of the email
  end
end
