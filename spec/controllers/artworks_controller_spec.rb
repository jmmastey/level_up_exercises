require 'rails_helper'
require Rails.root.join("spec/support/support_methods.rb")

RSpec.describe ArtworksController, :type => :controller do
  describe "GET #index" do
    let(:artist) { create(:artist) }

    context "when user is not logged in" do

      it "can access artworks index page" do
        get :index, { artist_id: artist.id }

        expect(response).to be_success
      end
    end

    context "when user is logged in" do

        it "can access artworks index page" do
          create_and_sign_in_user

          get :index, { artist_id: artist.id }

          expect(response).to be_success
        end
    end
  end

  describe "GET #show" do

    context "when user is not logged in" do

      it "can access an artwork show page" do
        artwork = FactoryGirl.create(:artwork)
        artist = FactoryGirl.create(:artist) do |artist|
          artist.artworks << artwork
        end

        get :show, { artist_id: artist.id, id: artwork.id }

        expect(response).to be_success
      end
    end

    context "when user is logged in" do

        it "can access an artwork show page" do
          artwork = FactoryGirl.create(:artwork)
          artist = FactoryGirl.create(:artist) do |artist|
            artist.artworks << artwork
          end

          create_and_sign_in_user

          get :show, { artist_id: artist.id, id: artwork.id }

          expect(response).to be_success
        end
    end
  end

  describe "GET #new" do
    let(:artist) { create(:artist) }

    context "when user is not logged in" do

      it "cannot access new artwork page" do
        get :new, { artist_id: artist.id }

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can access new artwork page" do
        create_and_sign_in_user

        get :new, { artist_id: artist.id }

        expect(response).to be_success
      end
    end
  end

  describe "POST #create" do
    let(:artist) { create(:artist) }
    let(:artwork) { create(:artwork) }

    context "when user is not logged in" do

      it "cannot create a new artwork" do
        post :create, { artist_id: artist.id, artwork: { title: artwork.title, date: artwork.date }}

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can create a new artwork" do
        create_and_sign_in_user

        post :create, { artist_id: artist.id, artwork: { title: artwork.title, date: artwork.date }}

        expect(response).to be_redirect
      end
    end
  end

  describe "GET #edit" do

    context "when user is not logged in" do

      it "cannot access edit artist page" do
        artwork = FactoryGirl.create(:artwork)
        artist = FactoryGirl.create(:artist) do |artist|
          artist.artworks << artwork
        end

        get :edit, { artist_id: artist.id, id: artwork.id }

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can access edit artist page" do
        artwork = FactoryGirl.create(:artwork)
        artist = FactoryGirl.create(:artist) do |artist|
          artist.artworks << artwork
        end

        create_and_sign_in_user

        get :edit, { artist_id: artist.id, id: artwork.id }

        expect(response).to be_success
      end
    end
  end

  describe "PATCH #update" do

    context "when user is not logged in" do

      it "cannot update a new artist" do
        artwork = FactoryGirl.create(:artwork)
        artist = FactoryGirl.create(:artist) do |artist|
          artist.artworks << artwork
        end

        patch :update, { artist_id: artist.id, id: artwork.id, artwork: { title: "New Title" }}

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can update a new artist" do
        artwork = FactoryGirl.create(:artwork)
        artist = FactoryGirl.create(:artist) do |artist|
          artist.artworks << artwork
        end

        create_and_sign_in_user

        patch :update, { artist_id: artist.id, id: artwork.id, artwork: { title: "New Title" }}

        expect(response).to be_redirect
      end
    end
  end

  describe "DELETE #destroy" do

    context "when user is not logged in" do

      it "cannot update a new artist" do
        artwork = FactoryGirl.create(:artwork)
        artist = FactoryGirl.create(:artist) do |artist|
          artist.artworks << artwork
        end

        delete :destroy, { artist_id: artist.id, id: artwork.id }

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

      it "can update a new artist" do
        artwork = FactoryGirl.create(:artwork)
        artist = FactoryGirl.create(:artist) do |artist|
          artist.artworks << artwork
        end

        create_and_sign_in_user

        delete :destroy, { artist_id: artist.id, id: artwork.id }

        expect(response).to be_redirect
      end
    end
  end
end
