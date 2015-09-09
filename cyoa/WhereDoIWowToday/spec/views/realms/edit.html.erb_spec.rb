require 'rails_helper'

RSpec.describe "realms/edit", type: :view do
  before(:each) do
    @realm = assign(:realm, Realm.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit realm form" do
    render

    assert_select "form[action=?][method=?]", realm_path(@realm), "post" do

      assert_select "input#realm_name[name=?]", "realm[name]"
    end
  end
end
