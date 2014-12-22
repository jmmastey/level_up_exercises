require 'rails_helper'

describe "items/index.html.haml", type: :view do
  it "renders the search partial" do
    stub_template("items/_search.html.haml" => "search_partial")
    render
    expect(rendered).to match(/search_partial/)
  end

  context "when no items exist" do
    it 'reports "No items found."' do
      render
      expect(rendered).to match(/No items found\./)
    end
  end

  context "when items exist" do
    before(:each) do
      items = [FactoryGirl.create(:item),
               FactoryGirl.create(:item)]
      assign(:items, items)
    end

    it "renders the list partial" do
      stub_template("items/_list.html.haml" => "list_partial")
      render
      expect(rendered).to match(/list_partial/)
    end
  end
end
