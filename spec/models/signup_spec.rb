require 'rails_helper'

RSpec.describe Signup, :type => :model do
  describe FreeSignup do
    let(:user) { Fabricate(:user) }
    it 'when influential it changes user freebie_count' do
      expect{
        Fabricate.create(:signup, user: user, influential: true, type: 'FreeSignup')
      }.to change{user.freebie_count}.by -1
    end
    it 'when not influential it does not change user freebie_count' do
      expect{
        Fabricate.create(:signup, user: user, influential: false, type: 'FreeSignup')
      }.not_to change{user.freebie_count}
    end
  end
end
