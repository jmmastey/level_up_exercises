require 'rails_helper'

RSpec.describe "achievements/index", type: :view do
  before(:each) do
    assign(:achievements, [
      Achievement.create!(
        :blizzard_id => 1,
        :title => "Title",
        :faction_id => 2
      ),
      Achievement.create!(
        :blizzard_id => 1,
        :title => "Title",
        :faction_id => 2
      )
    ])
  end

  it "renders a list of achievements" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
