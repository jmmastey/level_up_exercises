require 'rails_helper'

RSpec.describe "legislators/show", :type => :view do
  before(:each) do
    @legislator = assign(:legislator, Legislator.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
