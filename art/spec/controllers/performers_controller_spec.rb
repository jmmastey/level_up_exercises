require 'rails_helper'

RSpec.describe PerformersController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Performer. As you add validations to Performer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.attributes_for(:performer)
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PerformersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all performers as @performers" do
      performer = Performer.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:performers)).to eq([performer])
    end
  end

  describe "GET show" do
    it "assigns the requested performer as @performer" do
      performer = Performer.create! valid_attributes
      get :show, {:id => performer.to_param}, valid_session
      expect(assigns(:performer)).to eq(performer)
    end
  end

  describe "GET new" do
    it "assigns a new performer as @performer" do
      get :new, {}, valid_session
      expect(assigns(:performer)).to be_a_new(Performer)
    end
  end

  describe "GET edit" do
    it "assigns the requested performer as @performer" do
      performer = Performer.create! valid_attributes
      get :edit, {:id => performer.to_param}, valid_session
      expect(assigns(:performer)).to eq(performer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Performer" do
        expect {
          post :create, {:performer => valid_attributes}, valid_session
        }.to change(Performer, :count).by(1)
      end

      it "assigns a newly created performer as @performer" do
        post :create, {:performer => valid_attributes}, valid_session
        expect(assigns(:performer)).to be_a(Performer)
        expect(assigns(:performer)).to be_persisted
      end

      it "redirects to the created performer" do
        post :create, {:performer => valid_attributes}, valid_session
        expect(response).to redirect_to(Performer.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved performer as @performer" do
        post :create, {:performer => invalid_attributes}, valid_session
        expect(assigns(:performer)).to be_a_new(Performer)
      end

      it "re-renders the 'new' template" do
        post :create, {:performer => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { name: "Josh" }
      }

      it "updates the requested performer" do
        performer = Performer.create! valid_attributes
        put :update, {:id => performer.to_param, :performer => new_attributes}, valid_session
        performer.reload
        expect(performer.name).to eq(new_attributes[:name])
      end

      it "assigns the requested performer as @performer" do
        performer = Performer.create! valid_attributes
        put :update, {:id => performer.to_param, :performer => valid_attributes}, valid_session
        expect(assigns(:performer)).to eq(performer)
      end

      it "redirects to the performer" do
        performer = Performer.create! valid_attributes
        put :update, {:id => performer.to_param, :performer => valid_attributes}, valid_session
        expect(response).to redirect_to(performer)
      end
    end

    describe "with invalid params" do
      it "assigns the performer as @performer" do
        performer = Performer.create! valid_attributes
        put :update, {:id => performer.to_param, :performer => invalid_attributes}, valid_session
        expect(assigns(:performer)).to eq(performer)
      end

      it "re-renders the 'edit' template" do
        performer = Performer.create! valid_attributes
        put :update, {:id => performer.to_param, :performer => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested performer" do
      performer = Performer.create! valid_attributes
      expect {
        delete :destroy, {:id => performer.to_param}, valid_session
      }.to change(Performer, :count).by(-1)
    end

    it "redirects to the performers list" do
      performer = Performer.create! valid_attributes
      delete :destroy, {:id => performer.to_param}, valid_session
      expect(response).to redirect_to(performers_url)
    end
  end

end
