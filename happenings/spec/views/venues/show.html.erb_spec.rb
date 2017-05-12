require 'rails_helper'

RSpec.describe "venues/show", type: :view do
  before(:each) do
    @venue = FactoryGirl.create(:venue)
  end

  it "renders attributes in <p>" do
    render
  end
end
