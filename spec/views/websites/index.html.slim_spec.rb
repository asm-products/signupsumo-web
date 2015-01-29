require 'rails_helper'

RSpec.describe "websites/index", :type => :view do
  before(:each) do
    assign(:websites, [
      Fabricate(:website),
      Fabricate(:website, user: Fabricate(:user, email: 'abracadebra@example.com'))
    ])
  end

  it "renders a list of websites" do
    render
  end
end
