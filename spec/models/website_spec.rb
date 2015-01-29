require 'rails_helper'

RSpec.describe Website, :type => :model do
  
  describe 'validation' do
    it 'should not create with empty name' do
      website = Fabricate.build(:website, name: "")
      expect(website.save).to be_falsey
    end

    it 'should not create with empty host' do
      website = Fabricate.build(:website, host: "")
      expect(website.save).to be_falsey
    end

    it 'should not create with empty user' do
      website = Fabricate.build(:website, user: nil)
      expect(website.save).to be_falsey
    end

    it 'should generate a secret token' do
      website = Fabricate(:website)
      expect(website).to be_valid
    end
  end

  describe 'relationships' do
    it 'should delete registers when website is deleted' do
      website = Fabricate(:website)
      register = website.registers.create!(:profile => Fabricate(:profile))
      expect {
          Website.destroy(website)
        }.to change(Register, :count).by(-1)
    end

    it 'should not delete profiles when website is deleted' do
      website = Fabricate(:website)
      register = website.registers.create!(:profile => Fabricate(:profile))
      expect {
          Website.destroy(website)
        }.to_not change(Profile, :count)
    end
  end

  describe 'formatting' do 
    it 'should format the url before saving' do
      website = Fabricate(:website, host: 'https://example.org')
      expect(website.host).to eq(URI.parse('https://example.org').host)
    end
  end
end
