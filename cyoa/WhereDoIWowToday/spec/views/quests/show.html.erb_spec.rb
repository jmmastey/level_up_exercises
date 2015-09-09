require 'rails_helper'

RSpec.describe "quests/show", type: :view do
  before(:each) do
    @quest = assign(:quest, Quest.create!(
      :blizzard_id => 1,
      :title => "Title",
      :category => "Category",
      :req_level => 2,
      :level => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
