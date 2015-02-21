require 'rails_helper'

RSpec.describe ChecksInfluenceJob, :type => :job do

  let(:user) do
    Fabricate(:user)
  end

  let(:stub_clearbit_request) do
    stub_request(:get, "https://person-stream.clearbit.com/v1/people/email/pg@ycombinator.com")
  end

  it 'checks influence' do
    clearbit_request = stub_clearbit_request.
      to_return(File.new('spec/webmocks/influential_person.txt'))

    ChecksInfluenceJob.new.perform(user, 'pg@ycombinator.com')

    expect(clearbit_request).to have_been_made
  end

  it 'creates FreeSignup' do
    stub_clearbit_request.
      to_return(File.new('spec/webmocks/influential_person.txt'))

    expect{
      ChecksInfluenceJob.new.perform(user, 'pg@ycombinator.com')
    }.to change{ FreeSignup.count }.by 1
  end
  it 'creates SubscriptionSignup' do
    stub_clearbit_request.
      to_return(File.new('spec/webmocks/influential_person.txt'))

    user.update(freebie_count: 0)

    expect{
      ChecksInfluenceJob.new.perform(user, 'pg@ycombinator.com')
    }.to change{ SubscriptionSignup.count }.by 1
  end
  it 'delivers influencer email' do
    stub_clearbit_request.
      to_return(File.new('spec/webmocks/influential_person.txt'))
    expect(InfluencerMailer).to receive(:influencer_email).and_call_original

    ChecksInfluenceJob.new.perform(user, 'pg@ycombinator.com')
  end
  it 'does not deliver influencer email' do
    stub_clearbit_request.
      to_return(File.new('spec/webmocks/noninfluential_person.txt'))
    stub_request(:get, "https://company-stream.clearbit.com/v1/companies/domain/ycombinator.com").
      to_return(File.new('spec/webmocks/noninfluential_company.txt'))
    expect(InfluencerMailer).not_to receive(:influencer_email)

    ChecksInfluenceJob.new.perform(user, 'pg@ycombinator.com')
  end

end
