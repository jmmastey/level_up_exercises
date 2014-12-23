require 'rails_helper'
require Rails.root.join("spec/support/support_methods.rb")

RSpec.describe ArtistsController, :type => :controller do

  describe "GET #index" do

    context "when user is not logged in" do

      it "can access artist index page" do
        get :index

        expect(response).to be_success
      end
    end

    context "when user is logged in" do

        it "can access artist index page" do
          create_and_sign_in_user

          get :index

          expect(response).to be_success
        end
    end
  end

  describe "GET #show" do
    let(:artist) { create(:artist) }

    context "when user is not logged in" do

      it "can access an artist show page" do
        get :show, { id: artist.id }

        expect(response).to be_success
      end
    end

    context "when user is logged in" do

        it "can access an artist show page" do
          create_and_sign_in_user

          get :show, { id: artist.id }

          expect(response).to be_success
        end
    end
  end

  describe "GET #new" do

    context "when user is not logged in" do

      it "cannot access new artist page" do
        get :new

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can access new artist page" do
        create_and_sign_in_user

        get :new

        expect(response).to be_success
      end
    end
  end

  describe "POST #create" do
    let(:artist) { create(:artist) }

    context "when user is not logged in" do

      it "cannot create a new artist" do
        post :create, artist: { first_name: artist.first_name, last_name: artist.last_name }

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can create a new artist" do
        create_and_sign_in_user

        post :create, artist: { first_name: artist.first_name, last_name: artist.last_name }

        expect(response).to be_redirect
      end
    end
  end

  describe "GET #edit" do
    let(:artist) { create(:artist) }

    context "when user is not logged in" do

      it "cannot access edit artist page" do
        get :edit, { id: artist.id }

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can access edit artist page" do
        create_and_sign_in_user

        get :edit, { id: artist.id }

        expect(response).to be_success
      end
    end
  end

  describe "PATCH #update" do
    let(:artist) { create(:artist) }

    context "when user is not logged in" do

      it "cannot update a new artist" do
        patch :update, id: artist, artist: { first_name: "New Name" }

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can update a new artist" do
        create_and_sign_in_user

        patch :update, id: artist, artist: { first_name: "New Name" }

        expect(response).to be_redirect
      end
    end
  end

  describe "DELETE #destroy" do
    let(:artist) { create(:artist) }

    context "when user is not logged in" do

      it "cannot update a new artist" do
        delete :destroy, id: artist

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can update a new artist" do
        create_and_sign_in_user

        delete :destroy, id: artist

        expect(response).to be_redirect
      end
    end
  end
end
