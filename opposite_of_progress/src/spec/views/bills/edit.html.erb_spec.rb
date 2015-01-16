require 'rails_helper'

RSpec.describe "bills/edit", :type => :view do
  before(:each) do
    @bill = assign(:bill, Bill.create!())
  end

  it "renders the edit bill form" do
    render

    assert_select "form[action=?][method=?]", bill_path(@bill), "post" do
    end
  end
end
