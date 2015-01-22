require 'rails_helper'

RSpec.describe Register, :type => :model do

  describe 'validation' do
    it 'should not create without website' do
      register = Register.create(:profile => Fabricate(:profile))
      expect(register.save).to be_falsey
    end

    it 'should not create without profile' do
      register = Register.create(:website => Fabricate(:website))
      expect(register.save).to be_falsey
    end
  end


end
