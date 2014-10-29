require 'rails_helper'

RSpec.describe WatchesController, :type => :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all watches as @watches" do
      watch = Watch.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:watches)).to eq([watch])
    end
  end

  describe "GET show" do
    it "assigns the requested watch as @watch" do
      watch = Watch.create! valid_attributes
      get :show, {:id => watch.to_param}, valid_session
      expect(assigns(:watch)).to eq(watch)
    end
  end

  describe "GET new" do
    it "assigns a new watch as @watch" do
      get :new, {}, valid_session
      expect(assigns(:watch)).to be_a_new(Watch)
    end
  end

  describe "GET edit" do
    it "assigns the requested watch as @watch" do
      watch = Watch.create! valid_attributes
      get :edit, {:id => watch.to_param}, valid_session
      expect(assigns(:watch)).to eq(watch)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Watch" do
        expect {
          post :create, {:watch => valid_attributes}, valid_session
        }.to change(Watch, :count).by(1)
      end

      it "assigns a newly created watch as @watch" do
        post :create, {:watch => valid_attributes}, valid_session
        expect(assigns(:watch)).to be_a(Watch)
        expect(assigns(:watch)).to be_persisted
      end

      it "redirects to the created watch" do
        post :create, {:watch => valid_attributes}, valid_session
        expect(response).to redirect_to(Watch.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved watch as @watch" do
        post :create, {:watch => invalid_attributes}, valid_session
        expect(assigns(:watch)).to be_a_new(Watch)
      end

      it "re-renders the 'new' template" do
        post :create, {:watch => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested watch" do
        watch = Watch.create! valid_attributes
        put :update, {:id => watch.to_param, :watch => new_attributes}, valid_session
        watch.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested watch as @watch" do
        watch = Watch.create! valid_attributes
        put :update, {:id => watch.to_param, :watch => valid_attributes}, valid_session
        expect(assigns(:watch)).to eq(watch)
      end

      it "redirects to the watch" do
        watch = Watch.create! valid_attributes
        put :update, {:id => watch.to_param, :watch => valid_attributes}, valid_session
        expect(response).to redirect_to(watch)
      end
    end

    describe "with invalid params" do
      it "assigns the watch as @watch" do
        watch = Watch.create! valid_attributes
        put :update, {:id => watch.to_param, :watch => invalid_attributes}, valid_session
        expect(assigns(:watch)).to eq(watch)
      end

      it "re-renders the 'edit' template" do
        watch = Watch.create! valid_attributes
        put :update, {:id => watch.to_param, :watch => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested watch" do
      watch = Watch.create! valid_attributes
      expect {
        delete :destroy, {:id => watch.to_param}, valid_session
      }.to change(Watch, :count).by(-1)
    end

    it "redirects to the watches list" do
      watch = Watch.create! valid_attributes
      delete :destroy, {:id => watch.to_param}, valid_session
      expect(response).to redirect_to(watches_url)
    end
  end

end
