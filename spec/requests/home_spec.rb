require 'rails_helper'

RSpec.describe 'Home' do
  before do
    get '/'
  end

  it 'renders successfully' do
    expect(response).to be_successful
  end

  it 'renders the index template' do
    expect(response).to render_template(:home)
  end

  it 'includes Connect message' do
    expect(response.body).to include('Connect')
  end
end
