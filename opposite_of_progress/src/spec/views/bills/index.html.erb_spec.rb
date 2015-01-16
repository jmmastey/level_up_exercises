require 'rails_helper'

RSpec.describe "bills/index", :type => :view do
  before(:each) do
    assign(:bills, [
      Bill.create!(),
      Bill.create!()
    ])
  end

  it "renders a list of bills" do
    render
  end
end
