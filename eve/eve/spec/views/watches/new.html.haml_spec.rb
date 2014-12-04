require 'rails_helper'

RSpec.describe "watches/new", type: :view do
  before(:each) do
    assign(:watch, Watch.new(
      nickname: "MyString",
      item: nil,
      user: nil
    ))
  end

  it "renders new watch form" do
    render

    assert_select "form[action=?][method=?]", watches_path, "post" do

      assert_select "input#watch_nickname[name=?]", "watch[nickname]"

      assert_select "input#watch_item_id[name=?]", "watch[item_id]"

      assert_select "input#watch_user_id[name=?]", "watch[user_id]"
    end
  end
end
