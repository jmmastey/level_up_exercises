require 'rails_helper'

RSpec.describe "character_zone_activities/edit", type: :view do
  before(:each) do
    @character_zone_activity = assign(:character_zone_activity, CharacterZoneActivity.create!())
  end

  it "renders the edit character_zone_activity form" do
    render

    assert_select "form[action=?][method=?]", character_zone_activity_path(@character_zone_activity), "post" do
    end
  end
end
