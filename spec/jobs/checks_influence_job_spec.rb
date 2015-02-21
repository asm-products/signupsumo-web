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

end
