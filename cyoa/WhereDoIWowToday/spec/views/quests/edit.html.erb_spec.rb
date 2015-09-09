require 'rails_helper'

RSpec.describe "quests/edit", type: :view do
  before(:each) do
    @quest = assign(:quest, Quest.create!(
      :blizzard_id => 1,
      :title => "MyString",
      :category => "MyString",
      :req_level => 1,
      :level => 1
    ))
  end

  it "renders the edit quest form" do
    render

    assert_select "form[action=?][method=?]", quest_path(@quest), "post" do

      assert_select "input#quest_blizzard_id[name=?]", "quest[blizzard_id]"

      assert_select "input#quest_title[name=?]", "quest[title]"

      assert_select "input#quest_category[name=?]", "quest[category]"

      assert_select "input#quest_req_level[name=?]", "quest[req_level]"

      assert_select "input#quest_level[name=?]", "quest[level]"
    end
  end
end
