require 'data_science/sample'
require 'data_science/view_helpers'
require_relative '../factories'

module DataScience
  describe Sample do
    let(:sample) { Sample.new }
    let(:sample_data) do
      [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
       { "date" => "2014-03-20", "cohort" => "B", "result" => 0 }]
    end

    it 'is instantiated with an empty array' do
      expect(sample.data_points).to be_empty
    end

    describe '#add_data_to_sample' do
      it 'adds a data point' do
        sample << sample_data

        expect(sample.data_points.size).to eq(2)
      end
    end

    context 'when calculating sample statistics' do
      before do
        sample.data_points += build_list(:data, 100, cohort: "A", result: 0)
        sample.data_points += build_list(:data, 50, cohort: "A", result: 1)
        sample.data_points += build_list(:data, 125, cohort: "B", result: 0)
        sample.data_points += build_list(:data, 50, cohort: "B", result: 1)
      end

      describe '#sample_size' do
        it 'calculates the total sample size' do
          expect(sample.sample_size).to eq(325)
        end
      end

      describe '#conversions' do
        it 'calculates the number of conversions' do
          expect(sample.conversions("A")).to eq(50)
          expect(sample.conversions("B")).to eq(50)
        end
      end

      describe '#non-conversions' do
        it 'calculates the number of non-conversions' do
          expect(sample.non_conversions("A")).to eq(100)
          expect(sample.non_conversions("B")).to eq(125)
        end
      end

      describe '#cohort_size' do
        it 'calculates the cohort size' do
          expect(sample.cohort_size("A")).to eq(150)
          expect(sample.cohort_size("B")).to eq(175)
        end
      end

      describe '#conversion_rate' do
        it 'calculates the conversion rate' do
          expect(sample.conversion_rate("A")).to be_within(0.0001).of(0.3333)
          expect(sample.conversion_rate("B")).to be_within(0.0001).of(0.2857)
        end
      end

      describe '#standard_error' do
        it 'calculates the standard error' do
          expect(sample.standard_error("A")).to be_within(0.0001).of(0.0384)
          expect(sample.standard_error("B")).to be_within(0.0001).of(0.0341)
        end
      end

      context 'when using 95% confidence' do
        describe '#error_bars' do
          it 'calculates the error bars' do
            expect(sample.error_bars("A")).to be_within(0.001).of(7.544)
            expect(sample.error_bars("B")).to be_within(0.001).of(6.693)
          end
        end

        describe '#confidence_level' do
          it 'calculates the confidence level' do
            expect(sample.confidence_level("A", "B")).to be_within(0.001).of(0.646)
          end
        end

        describe '#error_bars_helper' do
          it 'prints the error bars in % format with a precision of 2' do
            expect(sample.error_bars_helper("A")).to eq("7.54%")
            expect(sample.error_bars_helper("B")).to eq("6.69%")
          end
        end

        describe '#onversion_rate_helper' do
          it 'prints the conversion rates rounded to a precision of 2' do
            expect(sample.conversion_rate_helper("A")).to eq("33.3%")
            expect(sample.conversion_rate_helper("B")).to eq("28.6%")
          end
        end

        describe '#confidence_level_helper' do
          it 'print the confidence level in % format with a precision of 2' do
            expect(sample.confidence_level_helper("A", "B")).to eq("64.6%")
          end
        end
      end
    end
  end
end
