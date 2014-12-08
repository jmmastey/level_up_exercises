require 'spec_helper'

describe "items/_search", type: :view do
  it "has a form directed to /items/search" do
    render
    expect(rendered).to have_css("form[action~='items/search']")
  end

  it "has a query search field" do
    render
    expect(rendered).to have_css("input#query[type='search']")
  end

  context "when a query has been entered" do
    before(:each) { assign(:query, "Tritanium") }

    it "shows the query in the search field" do
      render
      expect(rendered).to have_css("input#query[value='Tritanium']")
    end
  end
end
