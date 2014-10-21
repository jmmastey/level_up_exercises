require 'rails_helper'

RSpec.describe "watches/index", :type => :view do
  before(:each) do
    assign(:watches, [
      Watch.create!(
        :nickname => "Nickname",
        :item => nil,
        :user => nil
      ),
      Watch.create!(
        :nickname => "Nickname",
        :item => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of watches" do
    render
    assert_select "tr>td", :text => "Nickname".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
