require_relative "../lib/eve_central.rb"

describe EveCentral do
  let(:eve_central) { EveCentral.new }
  let(:tritanium_id) { 34 }
  let(:pyerite_id) { 35 }
  let(:forge_id) { 10000002 }
  let(:tribute_id) { 10000010 }
  let(:odin_id) { 30002963 }

  it "can be constructed with no parameters" do
    expect { eve_central }.not_to raise_error
  end

  describe "#marketstat" do
    let(:tritanium_marketstat) { eve_central.marketstat(tritanium_id) }
    let(:multi_marketstat) { eve_central.marketstat([tritanium_id, pyerite_id]) }
    let(:hour_marketstat) { eve_central.marketstat(tritanium_id, hours: 6) }
    let(:qty_marketstat) { eve_central.marketstat(tritanium_id, min_qty: 1000) }

    let(:region_marketstat) do
      eve_central.marketstat(tritanium_id, regions: forge_id)
    end

    let(:multiregion_marketstat) do
      regions = [forge_id, tribute_id]
      eve_central.marketstat(tritanium_id, regions: regions)
    end

    let(:system_marketstat) do
      eve_central.marketstat(tritanium_id, system: odin_id)
    end

    it "accepts an item ID" do
      expect(tritanium_marketstat).not_to raise_error
    end

    it "accepts an array of item IDs" do
      expect(multi_market_stat).to raise_error
    end

    it "returns a hash of items" do
      expect(tritanium_marketstat).to be_a(Hash)
    end

    it "uses item IDs as keys" do
      id, _item = tritanium_marketstat.first
      expect(id).to eq(tritanium_id)
    end

    it "accepts a number of hours to filter by" do
      expect(hour_marketstat).not_to raise_error
    end

    it "accepts a minimum quantity" do
      expect(qty_marketstat).not_to raise_error
    end

    it "accepts a region filter with a single region ID" do
      expect(region_marketstat).not_to raise_error
    end

    it "accepts a region filter with multiple region IDs" do
      expect(multiregion_marketstat).not_to raise_error
    end

    it "accepts a system filter with a single system ID" do
      expect(system_marketstat).not_to raise_error
    end
  end

  describe "#quicklook" do
    let(:tritanium_quicklook) { eve_central.quicklook(tritanium_id) }

    let(:hour_quicklook) do
      eve_central.quicklook(tritanium_id, hours: 1000)
    end

    let(:region_quicklook) do
      eve_central.quicklook(tritanium_id, regions: forge_id)
    end

    let(:multiregion_quicklook) do
      regions = [forge_id, tribute_id]
      eve_central.quicklook(tritanium_id, regions: regions)
    end

    it "returns a hash of items" do
      expect(tritanium_quicklook).to be_a(Hash)
    end

    it "uses item IDs as keys" do
      id, _item = tritanium_quicklook.first
      expect(id).to eq(tritanium_id)
    end

    it "accepts a number of hours to filter by" do
      expect(hour_quicklook).not_to raise_error
    end
  end
end
