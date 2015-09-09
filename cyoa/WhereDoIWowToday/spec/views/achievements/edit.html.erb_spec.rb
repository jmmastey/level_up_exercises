require 'rails_helper'

RSpec.describe "achievements/edit", type: :view do
  before(:each) do
    @achievement = assign(:achievement, Achievement.create!(
      :blizzard_id => 1,
      :title => "MyString",
      :faction_id => 1
    ))
  end

  it "renders the edit achievement form" do
    render

    assert_select "form[action=?][method=?]", achievement_path(@achievement), "post" do

      assert_select "input#achievement_blizzard_id[name=?]", "achievement[blizzard_id]"

      assert_select "input#achievement_title[name=?]", "achievement[title]"

      assert_select "input#achievement_faction_id[name=?]", "achievement[faction_id]"
    end
  end
end
