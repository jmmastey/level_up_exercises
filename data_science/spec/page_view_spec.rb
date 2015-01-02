require_relative '../page_view.rb'

describe PageView do

  describe "#initialize" do
    let(:pageview) { PageView.new(cohort, result) }
    let(:cohort) { "A" }
    let(:result) { 1 }

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

      context "when cohort is not passed" do
        it "raises and error" do
          expect { PageView.new(result) }.to raise_error
        end
      end

      context "when result is not passed" do
        it "raises and error" do
          expect { PageView.new(cohort) }.to raise_error
        end
      end
    end

end