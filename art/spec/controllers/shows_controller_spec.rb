require 'rails_helper'

RSpec.describe ShowsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Show. As you add validations to Show, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.attributes_for(:show)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:show, name: nil)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ShowsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all shows as @shows" do
      show = Show.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:shows)).to eq([show])
    end
  end

  describe "GET show" do
    it "assigns the requested show as @show" do
      show = Show.create! valid_attributes
      get :show, {:id => show.to_param}, valid_session
      expect(assigns(:show)).to eq(show)
    end
  end

  describe "GET new" do
    it "assigns a new show as @show" do
      get :new, {}, valid_session
      expect(assigns(:show)).to be_a_new(Show)
    end
  end

  describe "GET edit" do
    it "assigns the requested show as @show" do
      show = Show.create! valid_attributes
      get :edit, {:id => show.to_param}, valid_session
      expect(assigns(:show)).to eq(show)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Show" do
        expect {
          post :create, {:show => valid_attributes}, valid_session
        }.to change(Show, :count).by(1)
      end

      it "assigns a newly created show as @show" do
        post :create, {:show => valid_attributes}, valid_session
        expect(assigns(:show)).to be_a(Show)
        expect(assigns(:show)).to be_persisted
      end

      it "redirects to the created show" do
        post :create, {:show => valid_attributes}, valid_session
        expect(response).to redirect_to(Show.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved show as @show" do
        post :create, {:show => invalid_attributes}, valid_session
        expect(assigns(:show)).to be_a_new(Show)
      end

      it "re-renders the 'new' template" do
        post :create, {:show => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { name: "Mitt Romney Dance Spectacular!" }
      }

      it "updates the requested show" do
        show = Show.create! valid_attributes
        put :update, {:id => show.to_param, :show => new_attributes}, valid_session
        show.reload
        expect(show.name).to eq(new_attributes[:name])
      end

      it "assigns the requested show as @show" do
        show = Show.create! valid_attributes
        put :update, {:id => show.to_param, :show => valid_attributes}, valid_session
        expect(assigns(:show)).to eq(show)
      end

      it "redirects to the show" do
        show = Show.create! valid_attributes
        put :update, {:id => show.to_param, :show => valid_attributes}, valid_session
        expect(response).to redirect_to(show)
      end
    end

    describe "with invalid params" do
      it "assigns the show as @show" do
        show = Show.create! valid_attributes
        put :update, {:id => show.to_param, :show => invalid_attributes}, valid_session
        expect(assigns(:show)).to eq(show)
      end

      it "re-renders the 'edit' template" do
        show = Show.create! valid_attributes
        put :update, {:id => show.to_param, :show => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested show" do
      show = Show.create! valid_attributes
      expect {
        delete :destroy, {:id => show.to_param}, valid_session
      }.to change(Show, :count).by(-1)
    end

    it "redirects to the shows list" do
      show = Show.create! valid_attributes
      delete :destroy, {:id => show.to_param}, valid_session
      expect(response).to redirect_to(shows_url)
    end
  end

end
