require 'rails_helper'

RSpec.describe "realms/index", type: :view do
  before(:each) do
    assign(:realms, [
      Realm.create!(
        :name => "Name"
      ),
      Realm.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of realms" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
