require 'rails_helper'

RSpec.describe "good_deeds/index", :type => :view do
  before(:each) do
    assign(:good_deeds, [
      GoodDeed.create!(),
      GoodDeed.create!()
    ])
  end

  it "renders a list of good_deeds" do
    render
  end
end
