require 'rails_helper'

RSpec.describe WebsitesController, :type => :controller do

  let (:current_user) { Fabricate(:user) }

  before(:each) do
    sign_in current_user
  end

  def valid_attributes
    {
      name: 'SaaS',
      host: 'http://example.org',
      user: current_user
    }
  end

  def invalid_attributes
    {
      host: 'somecrazyapp.com'
    }
  end 

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all websites as @websites" do
      website = Website.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:websites)).to eq([website])
    end
  end

  describe "GET show" do
    it "assigns the requested website as @website" do
      website = Website.create! valid_attributes
      get :show, {:id => website.to_param}, valid_session
      expect(assigns(:website)).to eq(website)
    end
  end

  describe "GET new" do
    it "assigns a new website as @website" do
      get :new, {}, valid_session
      expect(assigns(:website)).to be_a_new(Website)
    end
  end

  describe "GET edit" do
    it "assigns the requested website as @website" do
      website = Website.create! valid_attributes
      get :edit, {:id => website.to_param}, valid_session
      expect(assigns(:website)).to eq(website)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Website" do
        expect {
          post :create, {:website => valid_attributes}, valid_session
        }.to change(Website, :count).by(1)
      end

      it "assigns a newly created website as @website" do
        post :create, {:website => valid_attributes}, valid_session
        expect(assigns(:website)).to be_a(Website)
        expect(assigns(:website)).to be_persisted
      end

      it "redirects to the created website" do
        post :create, {:website => valid_attributes}, valid_session
        expect(response).to redirect_to(Website.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved website as @website" do
        post :create, {:website => invalid_attributes}, valid_session
        expect(assigns(:website)).to be_a_new(Website)
      end

      it "re-renders the 'new' template" do
        post :create, {:website => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      def new_attributes
        {
          name: 'IaaS',
          host: 'http://iprovideinfratoyou.org',
          user: current_user
        }
      end

      it "updates the requested website" do
        website = Website.create! valid_attributes
        put :update, {:id => website.to_param, :website => new_attributes}, valid_session
        website.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested website as @website" do
        website = Website.create! valid_attributes
        put :update, {:id => website.to_param, :website => valid_attributes}, valid_session
        expect(assigns(:website)).to eq(website)
      end

      it "redirects to the website" do
        website = Website.create! valid_attributes
        put :update, {:id => website.to_param, :website => valid_attributes}, valid_session
        expect(response).to redirect_to(website)
      end
    end

    describe "with invalid params" do
      it "assigns the website as @website" do
        website = Website.create! valid_attributes
        put :update, {:id => website.to_param, :website => invalid_attributes}, valid_session
        expect(assigns(:website)).to eq(website)
      end

      it "re-renders the 'edit' template" do
        skip('Create a new website and edit it with invalid params')
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested website" do
      website = Website.create! valid_attributes
      expect {
        delete :destroy, {:id => website.to_param}, valid_session
      }.to change(Website, :count).by(-1)
    end

    it "redirects to the websites list" do
      website = Website.create! valid_attributes
      delete :destroy, {:id => website.to_param}, valid_session
      expect(response).to redirect_to(websites_url)
    end
  end

end
