require 'rails_helper'

RSpec.describe ReviewsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Review. As you add validations to Review, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.build(:review).attributes.symbolize_keys
  }

  let(:invalid_attributes) {
    { user_id: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ReviewsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all reviews as @reviews" do
      review = Review.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:reviews)).to eq([review])
    end
  end

  describe "GET show" do
    it "assigns the requested review as @review" do
      review = Review.create! valid_attributes
      get :show, {:id => review.to_param}, valid_session
      expect(assigns(:review)).to eq(review)
    end
  end

  describe "GET new" do
    it "assigns a new review as @review" do
      get :new, {}, valid_session
      expect(assigns(:review)).to be_a_new(Review)
    end
  end

  describe "GET edit" do
    it "assigns the requested review as @review" do
      review = Review.create! valid_attributes
      get :edit, {:id => review.to_param}, valid_session
      expect(assigns(:review)).to eq(review)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Review" do
        expect {
          post :create, {:review => valid_attributes}, valid_session
        }.to change(Review, :count).by(1)
      end

      it "assigns a newly created review as @review" do
        post :create, {:review => valid_attributes}, valid_session
        expect(assigns(:review)).to be_a(Review)
        expect(assigns(:review)).to be_persisted
      end

      it "redirects to the created review" do
        post :create, {:review => valid_attributes}, valid_session
        expect(response).to redirect_to(Review.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved review as @review" do
        post :create, {:review => invalid_attributes}, valid_session
        expect(assigns(:review)).to be_a_new(Review)
      end

      it "re-renders the 'new' template" do
        post :create, {:review => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { user_id: FactoryBot.create(:user).id }
      }

      it "updates the requested review" do
        review = Review.create! valid_attributes
        put :update, {:id => review.to_param, :review => new_attributes}, valid_session
        review.reload
        expect(review.user_id).to eq(new_attributes[:user_id])
      end

      it "assigns the requested review as @review" do
        review = Review.create! valid_attributes
        put :update, {:id => review.to_param, :review => valid_attributes}, valid_session
        expect(assigns(:review)).to eq(review)
      end

      it "redirects to the review" do
        review = Review.create! valid_attributes
        put :update, {:id => review.to_param, :review => valid_attributes}, valid_session
        expect(response).to redirect_to(review)
      end
    end

    describe "with invalid params" do
      it "assigns the review as @review" do
        review = Review.create! valid_attributes
        put :update, {:id => review.to_param, :review => invalid_attributes}, valid_session
        expect(assigns(:review)).to eq(review)
      end

      it "re-renders the 'edit' template" do
        review = Review.create! valid_attributes
        put :update, {:id => review.to_param, :review => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested review" do
      review = Review.create! valid_attributes
      expect {
        delete :destroy, {:id => review.to_param}, valid_session
      }.to change(Review, :count).by(-1)
    end

    it "redirects to the reviews list" do
      review = Review.create! valid_attributes
      delete :destroy, {:id => review.to_param}, valid_session
      expect(response).to redirect_to(reviews_url)
    end
  end

end
