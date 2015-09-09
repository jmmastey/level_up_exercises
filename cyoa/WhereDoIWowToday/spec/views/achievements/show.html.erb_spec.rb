require 'rails_helper'

RSpec.describe "achievements/show", type: :view do
  before(:each) do
    @achievement = assign(:achievement, Achievement.create!(
      :blizzard_id => 1,
      :title => "Title",
      :faction_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/2/)
  end
end
