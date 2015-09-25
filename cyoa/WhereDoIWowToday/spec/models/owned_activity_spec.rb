require 'rails_helper'

RSpec.describe OwnedActivity, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:character) { FactoryGirl.create(:character) }
  let(:zone) { FactoryGirl.create(:category, blizzard_type: "zone") }
  let(:activity) do
    FactoryGirl.create(:activity, character: character, category: zone)
  end
  let(:user2) { FactoryGirl.create(:user) }
  let(:character2) { FactoryGirl.create(:character) }
  let(:zone2) { FactoryGirl.create(:category, blizzard_type: "zone") }
end
