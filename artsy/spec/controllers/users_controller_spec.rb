require 'rails_helper'
require Rails.root.join("spec/support/support_methods.rb")

RSpec.describe UsersController, :type => :controller do

  describe "GET #index" do

    context "when user is not logged in" do

      it "can't access user index page" do
        get :index

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

        it "can access user index page" do
          create_and_sign_in_user

          get :index

          expect(response).to be_success
        end
    end
  end

  describe "GET #show" do
    let(:user) { create(:user) }

    context "when user is not logged in" do

      it "cannot access their user show page" do
        get :show, { id: user.id }

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when user is logged in" do

        it "can access their user show page" do
          sign_in_user(user)

          get :show, { id: user.id }

          expect(response).to be_success
        end
    end
  end
end
