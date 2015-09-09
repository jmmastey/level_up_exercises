require 'rails_helper'

RSpec.describe "quests/new", type: :view do
  before(:each) do
    assign(:quest, Quest.new(
      :blizzard_id => 1,
      :title => "MyString",
      :category => "MyString",
      :req_level => 1,
      :level => 1
    ))
  end

  it "renders new quest form" do
    render

    assert_select "form[action=?][method=?]", quests_path, "post" do

      assert_select "input#quest_blizzard_id[name=?]", "quest[blizzard_id]"

      assert_select "input#quest_title[name=?]", "quest[title]"

      assert_select "input#quest_category[name=?]", "quest[category]"

      assert_select "input#quest_req_level[name=?]", "quest[req_level]"

      assert_select "input#quest_level[name=?]", "quest[level]"
    end
  end
end
