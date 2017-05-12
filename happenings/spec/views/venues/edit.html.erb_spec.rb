require 'rails_helper'

RSpec.describe "venues/edit", type: :view do
  before(:each) do
    @venue = FactoryGirl.create(:venue)
  end

  it "renders the edit venue form" do
    render

    assert_select "form[action=?][method=?]", venue_path(@venue), "post" do
    end
  end
end
