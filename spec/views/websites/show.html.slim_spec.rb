require 'rails_helper'

RSpec.describe "websites/show", :type => :view do
  before(:each) do
    @website = assign(:website, Website.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
