require 'rails_helper'

RSpec.describe "realms/new", type: :view do
  before(:each) do
    assign(:realm, Realm.new(
      :name => "MyString"
    ))
  end

  it "renders new realm form" do
    render

    assert_select "form[action=?][method=?]", realms_path, "post" do

      assert_select "input#realm_name[name=?]", "realm[name]"
    end
  end
end
