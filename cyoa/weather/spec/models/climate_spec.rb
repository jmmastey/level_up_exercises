require 'rails_helper'

RSpec.describe Climate, type: :model do
  let(:climate) { described_class }

  describe "#self.weekly_weather" do

  end

  describe "#self.persist_weather" do
    let(:persist_weather) { described_class.persist_weather }

    it "creates a Climate record" do
      expect { persist_weather }.to change { Climate.count }.by_at_least(1)
    end
    it "creates 7 days worth of Climate" do
      expect { persist_weather }.to change { Climate.count }.by(7)
    end
  end
end
