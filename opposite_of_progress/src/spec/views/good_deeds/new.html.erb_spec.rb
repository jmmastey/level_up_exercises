require 'rails_helper'

RSpec.describe "good_deeds/new", :type => :view do
  before(:each) do
    assign(:good_deed, GoodDeed.new())
  end

  it "renders new good_deed form" do
    render

    assert_select "form[action=?][method=?]", good_deeds_path, "post" do
    end
  end
end
