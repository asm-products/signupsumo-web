require 'rails_helper'

RSpec.describe "websites/index", :type => :view do
  before(:each) do
    assign(:websites, [
      Website.create!(),
      Website.create!()
    ])
  end

  it "renders a list of websites" do
    render
  end
end
