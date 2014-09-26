require 'rails_helper'

RSpec.describe "venues/show", :type => :view do
  before(:each) do
    @venue = assign(:venue, Venue.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
