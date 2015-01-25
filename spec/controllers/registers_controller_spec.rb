require 'rails_helper'

RSpec.describe RegistersController, :type => :controller do

  let (:website) { Fabricate(:website) }

  let(:profile) { Fabricate(:profile) }

  def valid_attributes
    {
      url: website.host,
      email: profile.email,
      token: website.secret_token
    }
  end

  def invalid_attributes
    {
      url: 'http://somenotregisteredwebsite.com',
      email: 'anewuser@example.com',
      token: SecureRandom.hex 
    }
  end

  describe "GET create" do
    describe "with valid params" do
      it "creates a new registration" do
        expect {
          get :create, valid_attributes
        }.to change(Register, :count).by(1)
      end
    end


    describe "with new profile" do
      it "adds the new profile to database" do #This test makes clearbit API calls
        expect {
          get :create, invalid_attributes
        }.to change(Profile, :count).by(1)
      end
    end

    describe "with unregistered website" do
      it "should not create the register" do
        expect {
          get :create, invalid_attributes
        }.to_not change(Register, :count)
      end
    end 

    describe "if already registered" do
      it "should not create the register" do
        register = Register.create!(website: website, profile: profile)
        expect {
          get :create, valid_attributes
        }.to_not change(Register, :count)
      end
    end       
  end

end
