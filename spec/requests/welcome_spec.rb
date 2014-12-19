require 'rails_helper'

RSpec.describe 'Welcome' do
  before do
    get '/'
  end

  it 'renders successfully' do
    expect(response).to be_successful
  end

  it 'renders the index template' do
    expect(response).to render_template(:index)
  end

  it 'includes welcome message' do
    expect(response.body).to include('Welcome')
  end
end
