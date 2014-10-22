require 'rails_helper'

RSpec.describe "watches/show", :type => :view do
  before(:each) do
    @watch = assign(:watch, Watch.create!(
      :nickname => "Nickname",
      :item => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nickname/)
    expect(rendered).to match(/Item/)
    expect(rendered).to match(/User/)
  end
end
