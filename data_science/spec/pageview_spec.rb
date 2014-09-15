require "rspec"
require "date"

require_relative "../pageview"

describe PageView do
  context "upon creation" do
    let(:testdate) { Date.parse("2001-02-03") }

    let(:pageview) do
      PageView.new(id: "idA", date: testdate, purchased: false)
    end

    it "will store parameters" do
      expect(pageview.id).to eq("idA")
      expect(pageview.date).to eq(testdate)
      expect(pageview.purchased).to eq(false)
    end
  end
end
