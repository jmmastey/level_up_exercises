require 'rails_helper'

RSpec.describe "venues/index", :type => :view do
  before(:each) do
    assign(:venues, [
      Venue.create!(),
      Venue.create!()
    ])
  end

  it "renders a list of venues" do
    render
  end
end
