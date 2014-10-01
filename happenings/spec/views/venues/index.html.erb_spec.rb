require 'rails_helper'

RSpec.describe "venues/index", type: :view do
  before(:each) do
    @venues = FactoryGirl.create_list(:venue, 2)
  end

  it "renders a list of venues" do
    render
  end
end
