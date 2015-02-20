require 'rails_helper'

RSpec.describe User, :type => :model do

  describe 'validation' do
    it 'should not create with empty email' do
      user = User.create(:password => 'strangepwd')
      expect(user.save).to be_falsey
    end

    it 'should not create duplicate email' do
      Fabricate(:user)
      user = Fabricate.build(:user)
      expect(user).not_to be_valid
    end

    it 'should not accept invalid email' do
      user = Fabricate.build(:user, email: 'some@invalid')
      expect(user).not_to be_valid
    end

    it 'should not accept password less than 8 characters' do
      user = Fabricate.build(:user, password: 'abc')
      expect(user).not_to be_valid
    end
  end

  describe '#at_signup_limit?' do
    context 'without subscription' do
      it 'returns true when exhausted_freebies?' do
        user = Fabricate.build(:user, password: 'abc', freebie_count: 0)
        expect(user.at_signup_limit?).to be_truthy
      end
      it 'returns false when !exhausted_freebies?' do
        user = Fabricate.build(:user, password: 'abc', freebie_count: 1)
        expect(user.at_signup_limit?).to be_falsey
      end
    end
    context 'with subscription' do
      it 'returns true when exhausted_freebies? and exhausted_subscription?' do
        user = Fabricate.create(:user, password: 'abc123567', freebie_count: 0)
        user.create_subscription(:customer => {
          :subscriptions => {
            :data => [{
              :status => 'active'
            }]
          }
        })
        100.times { Fabricate.create(:signup, user: user, influential: true) }

        expect(user.at_signup_limit?).to be_truthy
      end
      it 'returns false when !exhausted_freebies?' do
        user = Fabricate.create(:user, password: 'abc123567', freebie_count: 1)
        user.create_subscription(:customer => {
          :subscriptions => {
            :data => [{
              :status => 'active'
            }]
          }
        })
        100.times { Fabricate.create(:signup, user: user, influential: true) }

        expect(user.at_signup_limit?).to be_falsey
      end
      it 'returns false when !exhausted_subscription?' do
        user = Fabricate.create(:user, password: 'abc123567', freebie_count: 0)
        user.create_subscription(:customer => {
          :subscriptions => {
            :data => [{
              :status => 'active'
            }]
          }
        })
        99.times { Fabricate.create(:signup, user: user, influential: true) }

        expect(user.at_signup_limit?).to be_falsey
      end
    end
  end
end
