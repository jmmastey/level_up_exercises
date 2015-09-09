require 'rails_helper'

RSpec.describe "character_zone_activities/show", type: :view do
  before(:each) do
    @character_zone_activity = assign(:character_zone_activity, CharacterZoneActivity.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
