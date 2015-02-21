require 'rails_helper'

RSpec.describe '/api/v1/signups' do

  let(:user) do
    Fabricate(:user)
  end

  let(:signup_request) do
    get(signups_path,
      :token => user.authentication_token,
      :email => 'pg@ycombinator.com'
    )
  end

  it 'returns 200' do
    expect(signup_request).to eq 200
  end
  it 'returns response' do
    signup_request
    expect(json).to include('response' => 'Submitted successfully')
  end
  it 'queues ChecksInfluenceJob' do
    expect(ChecksInfluenceJob).to receive(:perform_later).with(user, 'pg@ycombinator.com')
    signup_request
  end
  it 'returns 400' do
    expect(get(signups_path,
      :token => 'invalid',
      :email => 'pg@ycombinator.com'
    )).to eq 400

    expect(get(signups_path,
      :email => 'pg@ycombinator.com'
    )).to eq 400

    expect(get(signups_path)).to eq 400
  end
end
