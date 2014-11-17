require 'data_science/cohort'
require 'data_science/view_helpers'

module DataScience
  describe Cohort do
    let(:cohort) { Cohort.new }

    it 'is instantiated with a 0 conversions' do
      expect(cohort.conversions).to eq(0)
    end

    it 'is instantiated with a 0 non-conversions' do
      expect(cohort.non_conversions).to eq(0)
    end

    it 'sums the conversions for a cohort' do
      data = [{ "date" => "2014-03-20", "cohort" => "A", "result" => 1 }]
      cohort.tally_conversions(data)
      expect(cohort.conversions).to eq(1)
      expect(cohort.non_conversions).to eq(0)
    end

    it 'sums the non-conversions for a cohort' do
        data = [{ "date" => "2014-03-20", "cohort" => "A", "result" => 0 }]
      cohort.tally_conversions(data)
      expect(cohort.conversions).to eq(0)
      expect(cohort.non_conversions).to eq(1)
    end

    context 'when calculating sample statistics' do
      let(:conversions) { 50 }
      let(:non_conversions) { 100 }

      describe '#conversions' do
        it 'provides the number of conversions' do
          cohort.conversions = 50
          expect(cohort.conversions).to eq(50)
        end
      end

      describe '#non-conversions' do
        it 'provides the number of non-conversions' do
          cohort.non_conversions = 100
          expect(cohort.non_conversions).to eq(100)
        end
      end

      describe '#cohort_size' do
        it 'calculates the cohort size' do
          cohort.conversions = 50
          cohort.non_conversions = 100
          expect(cohort.size).to eq(150)
        end
      end

      describe '#conversion_rate' do
        it 'calculates the conversion rate' do
          cohort.conversions = 50
          cohort.non_conversions = 100
          expect(cohort.conversion_rate).to be_within(0.0001).of(0.3333)
        end
      end

      describe '#standard_error' do
        it 'calculates the standard error' do
          cohort.conversions = 50
          cohort.non_conversions = 100
          expect(cohort.standard_error).to be_within(0.0001).of(0.0384)
        end
      end

      context 'when using 95% confidence' do
        describe '#error_bars' do
          it 'calculates the error bars' do
            cohort.conversions = 50
            cohort.non_conversions = 100
            expect(cohort.error_bars).to be_within(0.001).of(7.544)
          end
        end

        describe '#error_bars_helper' do
          it 'prints the error bars in % format with a precision of 2' do
            cohort.conversions = 50
            cohort.non_conversions = 100
            expect(cohort.error_bars_helper).to eq("7.54%")
          end
        end

        describe '#conversion_rate_helper' do
          it 'prints the conversion rates rounded to a precision of 2' do
            cohort.conversions = 50
            cohort.non_conversions = 100
            expect(cohort.conversion_rate_helper).to eq("33.3%")
          end
        end
      end
    end
  end
end
