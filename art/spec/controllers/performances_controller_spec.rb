require 'rails_helper'

RSpec.describe PerformancesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Performance. As you add validations to Performance, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.build(:performance).attributes.symbolize_keys
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for :performance, performed_on: nil
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PerformancesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all performances as @performances" do
      performance = Performance.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:performances)).to eq([performance])
    end
  end

  describe "GET show" do
    it "assigns the requested performance as @performance" do
      performance = Performance.create! valid_attributes
      get :show, {:id => performance.to_param}, valid_session
      expect(assigns(:performance)).to eq(performance)
    end
  end

  describe "GET new" do
    it "assigns a new performance as @performance" do
      get :new, {}, valid_session
      expect(assigns(:performance)).to be_a_new(Performance)
    end
  end

  describe "GET edit" do
    it "assigns the requested performance as @performance" do
      performance = Performance.create! valid_attributes
      get :edit, {:id => performance.to_param}, valid_session
      expect(assigns(:performance)).to eq(performance)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Performance" do
        expect {
          post :create, {:performance => valid_attributes}, valid_session
        }.to change(Performance, :count).by(1)
      end

      it "assigns a newly created performance as @performance" do
        post :create, {:performance => valid_attributes}, valid_session
        expect(assigns(:performance)).to be_a(Performance)
        expect(assigns(:performance)).to be_persisted
      end

      it "redirects to the created performance" do
        post :create, {:performance => valid_attributes}, valid_session
        expect(response).to redirect_to(Performance.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved performance as @performance" do
        post :create, {:performance => invalid_attributes}, valid_session
        expect(assigns(:performance)).to be_a_new(Performance)
      end

      it "re-renders the 'new' template" do
        post :create, {:performance => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { performed_on: 5.days.ago }
      }

      it "updates the requested performance" do
        performance = Performance.create! valid_attributes
        put :update, {:id => performance.to_param, :performance => new_attributes}, valid_session
        performance.reload
        expect(performance.performed_on).to eq(5.days.ago.to_date)
      end

      it "assigns the requested performance as @performance" do
        performance = Performance.create! valid_attributes
        put :update, {:id => performance.to_param, :performance => valid_attributes}, valid_session
        expect(assigns(:performance)).to eq(performance)
      end

      it "redirects to the performance" do
        performance = Performance.create! valid_attributes
        put :update, {:id => performance.to_param, :performance => valid_attributes}, valid_session
        expect(response).to redirect_to(performance)
      end
    end

    describe "with invalid params" do
      it "assigns the performance as @performance" do
        performance = Performance.create! valid_attributes
        put :update, {:id => performance.to_param, :performance => invalid_attributes}, valid_session
        expect(assigns(:performance)).to eq(performance)
      end

      it "re-renders the 'edit' template" do
        performance = Performance.create! valid_attributes
        put :update, {:id => performance.to_param, :performance => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested performance" do
      performance = Performance.create! valid_attributes
      expect {
        delete :destroy, {:id => performance.to_param}, valid_session
      }.to change(Performance, :count).by(-1)
    end

    it "redirects to the performances list" do
      performance = Performance.create! valid_attributes
      delete :destroy, {:id => performance.to_param}, valid_session
      expect(response).to redirect_to(performances_url)
    end
  end

end
