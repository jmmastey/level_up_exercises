require 'rails_helper'

RSpec.describe "good_deeds/edit", :type => :view do
  before(:each) do
    @good_deed = assign(:good_deed, GoodDeed.create!())
  end

  it "renders the edit good_deed form" do
    render

    assert_select "form[action=?][method=?]", good_deed_path(@good_deed), "post" do
    end
  end
end
