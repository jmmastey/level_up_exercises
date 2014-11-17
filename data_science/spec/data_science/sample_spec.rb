require 'data_science/sample'
require 'data_science/view_helpers'
require_relative '../factories'

module DataScience
  describe Sample do
    let(:sample) { Sample.new }
    let(:sample_data) {[
      { "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
      { "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
    ]}

    it 'is instantiated with an empty array' do
      expect(sample.data_points).to eq([])
    end

    describe '#add_data_to_sample' do
      it 'adds a data point' do
        sample << sample_data

        expect(sample.data_points.size).to eq(2)
      end
    end

    context 'when calculating sample statistics' do
      before do
        sample.data_points += build_list(:data, 744, cohort: "A", result: 0)
        sample.data_points += build_list(:data, 320, cohort: "A", result: 1)
        sample.data_points += build_list(:data, 793, cohort: "B", result: 0)
        sample.data_points += build_list(:data, 250, cohort: "B", result: 1)
      end

      describe '#sample_size' do
        it 'calculates the total sample size' do
          expect(sample.sample_size).to eq(2107)
        end
      end

      describe '#conversions' do
        it 'calculates the number of conversions' do
          expect(sample.conversions("A")).to eq(320)
          expect(sample.conversions("B")).to eq(250)
        end
      end

      describe '#non-conversions' do
        it 'calculates the number of non-conversions' do
          expect(sample.non_conversions("A")).to eq(744)
          expect(sample.non_conversions("B")).to eq(793)
        end
      end

      describe '#cohort_size' do
        it 'calculates the cohort size' do
          expect(sample.cohort_size("A")).to eq(1064)
          expect(sample.cohort_size("B")).to eq(1043)
        end
      end

      describe '#conversion_rate' do
        it 'calculates the conversion rate' do
          expect(sample.conversion_rate("A")).to be_within(0.0001).of(0.3008)
          expect(sample.conversion_rate("B")).to be_within(0.0001).of(0.2397)
        end
      end

      describe '#standard_error' do
        it 'calculates the standard error' do
          expect(sample.standard_error("A")).to be_within(0.00001).of(0.01406)
          expect(sample.standard_error("B")).to be_within(0.0001).of(0.0132)
        end
      end

      context 'when using 95% confidence' do
        describe '#error_bars' do
          it 'calculates the error bars' do
            expect(sample.error_bars("A")).to be_within(0.001).of(2.756)
            expect(sample.error_bars("B")).to be_within(0.001).of(2.590)
          end
        end

        describe '#confidence_level' do
          it 'calculates the confidence level' do
            expect(sample.confidence_level("A", "B"))
              .to be_within(0.001).of(0.998)
          end
        end

        describe '#error_bars_helper' do
          it 'prints the error bars in % format with a precision of 2' do
            expect(sample.error_bars_helper("A")).to eq("2.76%")
            expect(sample.error_bars_helper("B")).to eq("2.59%")
          end
        end

        describe '#onversion_rate_helper' do
          it 'prints the conversion rates rounded to a precision of 2' do
            expect(sample.conversion_rate_helper("A")).to eq("30.1%")
            expect(sample.conversion_rate_helper("B")).to eq("24.0%")
          end
        end

        describe '#confidence_level_helper' do
          it 'print the confidence level in % format with a precision of 2' do
            expect(sample.confidence_level_helper("A", "B")).to eq("99.8%")
          end
        end
      end
    end
  end
end
