 require 'data_science/cohort'
require 'data_science/view_helpers'

module DataScience
  describe Cohort do
    let(:cohort) { Cohort.new }
    let(:conversion_data) { [{ "date" => "2014-03-20", "cohort" => "A", "result" => 1 }] }
    let(:non_conversion_data) { [{ "date" => "2014-03-20", "cohort" => "A", "result" => 0 }] }

    it 'is instantiated with a 0 conversions' do
      expect(cohort.conversions).to be_zero
    end

    it 'is instantiated with a 0 non-conversions' do
      expect(cohort.non_conversions).to be_zero
    end

    it 'adds parsed split test data to the cohort' do
      cohort << conversion_data
      cohort << non_conversion_data
      expect(cohort.conversions).to eq(1)
      expect(cohort.non_conversions).to eq(1)
    end

    context 'adding website visit data to a cohort' do
      let(:conversions) { 50 }
      let(:non_conversions) { 100 }

      before do
        cohort.conversions = 50
        cohort.non_conversions = 100
      end

      describe '#conversions' do
        it 'sets the number of conversions' do
          expect(cohort.conversions).to be(50)
        end
      end

      describe '#non-conversions' do
        it 'sets the number of non-conversions' do
          expect(cohort.non_conversions).to be(100)
        end
      end

      context 'and calculating cohort statistics' do
        describe '#size' do
          it 'calculates the cohort size' do
            expect(cohort.size).to be(150)
          end
        end

        describe '#conversion_rate' do
          it 'calculates the conversion rate' do
            expect(cohort.conversion_rate).to be_within(0.0001).of(0.3333)
          end
        end

        describe '#standard_error' do
          it 'calculates the standard error' do
            expect(cohort.standard_error).to be_within(0.0001).of(0.0384)
          end
        end
      end

      context 'when using 95% confidence' do
        describe '#error_bars' do
          it 'calculates the error bars' do
            expect(cohort.error_bars).to be_within(0.001).of(7.544)
          end
        end

        describe '#error_bars_helper' do
          it 'prints the error bars in % format to a precision of 2' do
            pretty_error_bars = cohort.error_bars_helper
            expect(pretty_error_bars).to eq("7.54%")
          end
        end

        describe '#conversion_rate_helper' do
          it 'prints the conversion rates rounded to a precision of 2' do
            expect(cohort.conversion_rate_helper).to eq("33.3%")
          end
        end
      end
    end
  end
end
