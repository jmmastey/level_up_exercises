require "rails_helper"

describe "items/_list", type: :view do
  let(:items) { FactoryGirl.create_list(:item, 2) }

  before(:each) do
    items
    assign(:items, Item.all.page(1))
  end

  it "shows the EVE in-game ID" do
    render
    items.each do |item|
      expect(rendered).to have_css("td.field-in_game_id",
                                   text: item.in_game_id)
    end
  end

  it "shows the item name" do
    render
    items.each do |item|
      expect(rendered).to have_css("td.field-name", text: item.name)
    end
  end

  it "has a View Orders button" do
    render
    items.each do |item|
      expect(rendered).to have_css("tr#item-#{item.id} a",
                                   text: "View orders")
    end
  end
end
