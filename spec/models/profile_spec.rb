require 'rails_helper'

RSpec.describe Profile, :type => :model do

  describe 'validation' do
    it 'should not create with empty email' do
      profile = Profile.create(:data => 'strangepwd')
      expect(profile.save).to be_falsey
    end
  end

  describe 'relationships' do
    it 'should not delete registers when profile is deleted' do
      profile = Fabricate(:profile)
      register = profile.registers.create!(:website => Fabricate(:website))
      expect {
          Profile.destroy(profile)
        }.to_not change(Register, :count)
    end
  end

end
