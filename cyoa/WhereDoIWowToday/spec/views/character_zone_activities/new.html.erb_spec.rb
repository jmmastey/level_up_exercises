require 'rails_helper'

RSpec.describe "character_zone_activities/new", type: :view do
  before(:each) do
    assign(:character_zone_activity, CharacterZoneActivity.new())
  end

  it "renders new character_zone_activity form" do
    render

    assert_select "form[action=?][method=?]", character_zone_activities_path, "post" do
    end
  end
end
