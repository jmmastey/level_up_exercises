require 'rails_helper'

RSpec.describe "venues/new", type: :view do
  before(:each) do
    @venue = FactoryGirl.build(:venue)
  end

  it "renders new venue form" do
    render

    assert_select "form[action=?][method=?]", venues_path, "post" do
    end
  end
end
