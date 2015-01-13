require_relative '../page_view.rb'

describe PageView do
  let(:pageview) { PageView.new(cohort, result) }
  let(:cohort) { "A" }
  let(:result) { 1 }

  describe "#initialize" do
    context "when arguments are correct then" do
      it "has a name and result" do
        expect(pageview.cohort).to eq("A")
        expect(pageview.result).to eq(1)
      end
      it "they are the right type" do
        expect(pageview.cohort).to be_a(String)
        expect(pageview.result).to be_a(Integer)
      end
    end

    context "when no argument is passed" do
      it "raises an error" do
        expect { PageView.new }.to raise_error
      end
    end

    context "one argument is passed" do
      it "raises and error" do
        expect { PageView.new(result) }.to raise_error
        expect { PageView.new(cohort) }.to raise_error
      end
    end

    end


  describe "#converted?" do
    it "returns whether a cohort is converted" do
      expect(pageview.converted?).to eq(true)
    end
  end

  describe "#rejected?" do
    it "returns whether a cohort is rejected" do
      expect(pageview.rejected?).to eq(false)
    end
  end
end