require 'rails_helper'

RSpec.describe "websites/edit", :type => :view do
  before(:each) do
    @website = assign(:website, Fabricate(:website))
  end

  it "renders the edit website form" do
    render

    assert_select "form[action=?][method=?]", website_path(@website), "post" do
    end
  end
end
