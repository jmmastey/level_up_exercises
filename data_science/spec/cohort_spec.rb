require_relative '../cohort.rb'

  describe Cohort do
    context "when views are a mixed" do
      let(:pageviews) { [double(:result => 1), double(:result => 0), double(:result => 1)] }
      let(:cohort) { Cohort.new("A", pageviews) }

      it "has a name" do
        expect(cohort.name).to eq("A")
      end

      describe '#total_views' do
        it "counts the total views for a cohort" do
          expect(cohort.size).to eq(3)
        end
      end

      describe '#positive_conversions' do
        it "counts the positives" do
          expect(cohort.conversions).to eq(2)
        end
      end

      describe '#negative_conversions' do
        it "counts the negatives" do
          expect(cohort.rejections).to eq(1)
        end
      end

      describe '#conversion_rate' do
        it "gives correct conversion_rate" do
          expect(cohort.conversion_rate.round(2)).to eq(0.67)
        end
      end

      describe '#standard_error' do
        it "gives correct standard_error" do
          expect(cohort.standard_error.round(2)).to eq(0.27)
        end
      end
    end

    context "when view results are all negative" do
      let(:pageviews) { [double(:result => 0), double(:result => 0), double(:result => 0)] }
      let(:cohort) { Cohort.new("A", pageviews) }

      it "has a name" do
        expect(cohort.name).to eq("A")
      end

      describe '#total_views' do
        it "total number of views in the cohort" do
          expect(cohort.size).to eq(3)
        end
      end

      describe '#positive_conversions' do
        it "total number of views in the cohort" do
          expect(cohort.conversions).to eq(0)
        end
      end

      describe '#negative_conversions' do
        it "total number of views in the cohort" do
          expect(cohort.rejections).to eq(3)
        end
      end

      describe '#conversion_rate' do
        it "gives correct conversion_rate" do
          expect(cohort.conversion_rate.round(2)).to eq(0)
        end
      end

      describe '#standard_error' do
        it "gives correct standard_error" do
          expect(cohort.standard_error.round(2)).to eq(0)
        end
      end
    end

    context "when view results are all positive" do
      let(:pageviews) { [double(:result => 1), double(:result => 1), double(:result => 1)] }
      let(:cohort) { Cohort.new("A", pageviews) }

      it "has a name" do
        expect(cohort.name).to eq("A")
      end

      describe '#total_views' do
        it "total number of views in the cohort" do
          expect(cohort.size).to eq(3)
        end
      end

      describe '#positive_conversions' do
        it "total number of views in the cohort" do
          expect(cohort.conversions).to eq(3)
        end
      end

      describe '#negative_conversions' do
        it "total number of views in the cohort" do
          expect(cohort.rejections).to eq(0)
        end
      end

      describe '#conversion_rate' do
        it "gives correct conversion_rate" do
          expect(cohort.conversion_rate.round(2)).to eq(1)
        end
      end

      describe '#standard_error' do
        it "gives correct standard_error" do
          expect(cohort.standard_error.round(2)).to eq(0)
        end
      end
    end
  end
