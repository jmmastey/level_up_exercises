require 'rails_helper'

RSpec.describe "realms/show", type: :view do
  before(:each) do
    @realm = assign(:realm, Realm.create!(name: "Name"))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
