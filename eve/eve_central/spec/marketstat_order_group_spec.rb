require_relative "spec_helper"
require_relative "../lib/eve_central/marketstat_order_group"

describe EveCentral::MarketstatOrderGroup do
  let(:empty_group) { EveCentral::MarketstatOrderGroup.new }
  let(:average) { 5.46 }
  let(:maximum) { 15.00 }
  let(:median) { 5.40 }
  let(:minimum) { 1.00 }
  let(:percentile) { 4.11 }
  let(:standard_deviation) { 1.40 }
  let(:volume) { 47670156708 }

  let(:params) do
    {
      average: average,
      maximum: maximum,
      median: median,
      minimum: minimum,
      percentile: percentile,
      standard_deviation: standard_deviation,
      volume: volume
    }
  end

  let(:group) { EveCentral::MarketstatOrderGroup.new(params) }

  it "can be initialized with no parameters" do
    expect(empty_group).not_to be_nil
  end

  it "can be initialized with a hash of statistics" do
    expect(group).not_to be_nil
  end

  describe "#average" do
    it "is the average item price of orders in this group" do
      expect(group.average).to eq(average)
    end
  end

  describe "#maximum" do
    it "is the maximum item price of orders in this group" do
      expect(group.maximum).to eq(maximum)
    end
  end

  describe "#median" do
    it "is the median item price of orders in this group" do
      expect(group.median).to eq(median)
    end
  end

  describe "#minimum" do
    it "is the minimum item price of orders in this group" do
      expect(group.minimum).to eq(minimum)
    end
  end

  describe "#standard_deviation" do
    it "is the standard deviation of item prices of orders in this group" do
      expect(group.standard_deviation).to eq(standard_deviation)
    end
  end

  describe "#volume" do
    it "is the total volume of items of orders in this group" do
      expect(group.volume).to eq(volume)
    end
  end
end
