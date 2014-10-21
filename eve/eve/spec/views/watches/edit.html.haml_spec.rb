require 'rails_helper'

RSpec.describe "watches/edit", :type => :view do
  before(:each) do
    @watch = assign(:watch, Watch.create!(
      :nickname => "MyString",
      :item => nil,
      :user => nil
    ))
  end

  it "renders the edit watch form" do
    render

    assert_select "form[action=?][method=?]", watch_path(@watch), "post" do

      assert_select "input#watch_nickname[name=?]", "watch[nickname]"

      assert_select "input#watch_item_id[name=?]", "watch[item_id]"

      assert_select "input#watch_user_id[name=?]", "watch[user_id]"
    end
  end
end
