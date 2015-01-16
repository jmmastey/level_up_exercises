require 'rails_helper'

RSpec.describe "good_deeds/show", :type => :view do
  before(:each) do
    @good_deed = assign(:good_deed, GoodDeed.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
