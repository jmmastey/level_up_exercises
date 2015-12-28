require "rails_helper"

describe Location, type: :model do
  let(:location) { FactoryGirl.build(:location) }

  describe "#to_s" do
    subject(:to_s) { location.to_s }

    it "contains the street address" do
      expect(to_s).to include(location.street)
    end

    it "contains the city, state and ZIP" do
      [:city, :state, :zip].each do |field|
        expect(to_s).to include(location.send(field))
      end
    end

    context "when no street address is set" do
      before(:each) { location.street = "" }

      it "only includes the city, state and ZIP" do
        expect(to_s.lines.count).to eq(1)
      end
    end
  end
end
