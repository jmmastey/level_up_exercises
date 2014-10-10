require_relative "spec_helper"
require_relative "../lib/eve_central/item"

describe EveCentral::Item do
  include_context "item_ids"

  let(:default_item) { EveCentral::Item.new(tritanium_id) }
  let(:named_item) { EveCentral::Item.new(tritanium_id, tritanium_name) }

  it "is initialized with an ID" do
    expect(default_item.id).to eq(tritanium_id)
  end

  it "can be initialized with an optional name" do
    expect(named_item.name).to eq(tritanium_name)
  end

  it "should never be persisted" do
    expect(default_item).not_to be_persisted
  end

  it "should require the ID be an integer" do
    default_item.id = 0.5
    expect(default_item).not_to be_valid
  end

  it "should require the ID be nonnegative" do
    expect(default_item).to be_valid

    default_item.id = -1
    expect(default_item).not_to be_valid
  end

  context "when initialized with no id" do
    subject(:bad_item) { EveCentral::Item.new }

    it "should raise an error" do
      expect { bad_item }.to raise_error
    end
  end
end
