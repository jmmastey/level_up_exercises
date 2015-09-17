require 'rails_helper'

RSpec.describe QuestsController, type: :controller do
  describe "GET #show" do
    it "assigns the requested quest as @quest" do
      quest = Quest.create!(id: "1", blizzard_id_num: "1", title: "Quest Name")

      get :show, id: "1"

      expect(assigns(:quest)).to eq(quest)
    end
  end

  describe "GET #edit" do
    context "when logged in as an admin" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        sign_in FactoryGirl.create(:admin)
      end

      it "assigns the requested quest as @quest" do
        quest = Quest.create!(id: "1", blizzard_id_num: "1",
                              title: "Quest Name")

        get :edit, id: "1"

        expect(assigns(:quest)).to eq(quest)
      end

      it "allows the user to the edit page" do
        Quest.create!(id: "1", blizzard_id_num: "1", title: "Quest Name")

        get :edit, id: "1"

        expect(response.status).to eq(200)
      end
    end

    context "when logged in as a normal user" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:user)
      end

      it "should redirect to the show page" do
        quest = Quest.create!(id: "1", blizzard_id_num: "1",
                              title: "Quest Name")

        get :edit, id: "1"

        expect(response).to redirect_to(quest_path(quest))
      end
    end

    context "when not logged in" do
      before { sign_out :user }

      it "should redirect to the show page" do
        quest = Quest.create!(id: "1", blizzard_id_num: "1",
                              title: "Quest Name")

        get :edit, id: "1"

        expect(response).to redirect_to(quest_path(quest))
      end
    end
  end
end
