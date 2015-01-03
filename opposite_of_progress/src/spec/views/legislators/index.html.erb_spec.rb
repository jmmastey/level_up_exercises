require 'rails_helper'

RSpec.describe "legislators/index", :type => :view do
  before(:each) do
    assign(:legislators, [
      Legislator.create!(),
      Legislator.create!()
    ])
  end

  it "renders a list of legislators" do
    render
  end
end
