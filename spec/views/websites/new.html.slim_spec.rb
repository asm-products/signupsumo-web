require 'rails_helper'

RSpec.describe "websites/new", :type => :view do
  before(:each) do
    assign(:website, Website.new())
  end

  it "renders new website form" do
    render

    assert_select "form[action=?][method=?]", websites_path, "post" do
    end
  end
end
