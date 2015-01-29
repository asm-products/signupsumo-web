require 'rails_helper'

RSpec.describe "Websites", :type => :request do
  describe "GET /websites" do
    it "works! (now write some real specs)" do
      get websites_path
      expect(response).to have_http_status(302)
    end
  end
end
