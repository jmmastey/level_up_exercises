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
    it "should redirect to the show page" do
      quest = Quest.create!(id: "1", blizzard_id_num: "1",
                            title: "Quest Name")

      get :edit, id: "1"

      expect(response).to redirect_to(quest_path(quest))
    end
  end
end
