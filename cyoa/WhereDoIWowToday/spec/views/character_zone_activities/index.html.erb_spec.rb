require 'rails_helper'

RSpec.describe "character_zone_activities/index", type: :view do
  before(:each) do
    assign(:character_zone_activities, [
      CharacterZoneActivity.create!(),
      CharacterZoneActivity.create!()
    ])
  end

  it "renders a list of character_zone_activities" do
    render
  end
end
