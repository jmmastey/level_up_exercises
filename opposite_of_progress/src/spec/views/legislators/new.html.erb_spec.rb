require 'rails_helper'

RSpec.describe "legislators/new", :type => :view do
  before(:each) do
    assign(:legislator, Legislator.new())
  end

  it "renders new legislator form" do
    render

    assert_select "form[action=?][method=?]", legislators_path, "post" do
    end
  end
end
