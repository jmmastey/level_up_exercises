require 'rails_helper'

RSpec.describe "bills/new", :type => :view do
  before(:each) do
    assign(:bill, Bill.new())
  end

  it "renders new bill form" do
    render

    assert_select "form[action=?][method=?]", bills_path, "post" do
    end
  end
end
