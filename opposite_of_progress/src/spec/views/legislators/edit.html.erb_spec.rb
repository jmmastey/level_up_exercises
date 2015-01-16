require 'rails_helper'

RSpec.describe "legislators/edit", :type => :view do
  before(:each) do
    @legislator = assign(:legislator, Legislator.create!())
  end

  it "renders the edit legislator form" do
    render

    assert_select "form[action=?][method=?]", legislator_path(@legislator), "post" do
    end
  end
end
