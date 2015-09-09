require 'rails_helper'

RSpec.describe "quests/index", type: :view do
  before(:each) do
    assign(:quests, [
      Quest.create!(
        :blizzard_id => 1,
        :title => "Title",
        :category => "Category",
        :req_level => 2,
        :level => 3
      ),
      Quest.create!(
        :blizzard_id => 1,
        :title => "Title",
        :category => "Category",
        :req_level => 2,
        :level => 3
      )
    ])
  end

  it "renders a list of quests" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
