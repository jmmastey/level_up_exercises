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
  let(:volume) { 47_670_156_708 }

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

  it "is never persisted" do
    expect(group).not_to be_persisted
  end

  describe "#average" do
    it "is between the minimum and maximum values" do
      expect(group).to be_valid

      group.average = group.minimum - 0.1
      expect(group).not_to be_valid

      group.average = group.maximum + 0.1
      expect(group).not_to be_valid
    end
  end

  describe "#maximum" do
    it "requires that it be greater than or equal to the minimum" do
      expect(group).to be_valid

      group.maximum = group.minimum - 0.1
      expect(group).not_to be_valid
    end
  end

  describe "#median" do
    it "is between the minimum and maximum values" do
      expect(group).to be_valid

      group.median = group.minimum - 0.1
      expect(group).not_to be_valid

      group.median = group.maximum + 0.1
      expect(group).not_to be_valid
    end
  end

  describe "#minimum" do
    it "requires that it be non-negative" do
      expect(group).to be_valid

      group.minimum = -1
      expect(group).not_to be_valid
    end
  end

  describe "#percentile" do
    it "requires that it be between 0 and 100, inclusive" do
      group.percentile = 0
      expect(group).to be_valid

      group.percentile = 100
      expect(group).to be_valid

      group.percentile = -0.1
      expect(group).not_to be_valid

      group.percentile = 100.1
      expect(group).not_to be_valid
    end
  end

  describe "#standard_deviation" do
    it "requires that it be non-negative" do
      expect(group).to be_valid

      group.standard_deviation = -1
      expect(group).not_to be_valid
    end
  end

  describe "#volume" do
    it "requires that it be an integer" do
      group.volume = 2.3
      expect(group).not_to be_valid
    end

    it "requires that it be non-negative" do
      expect(group).to be_valid

      group.volume = -1
      expect(group).not_to be_valid
    end
  end
end
