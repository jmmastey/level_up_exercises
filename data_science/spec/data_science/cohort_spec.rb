require 'data_science/cohort'
require 'data_science/view_helpers'
require_relative 'spec_data'

module DataScience
  describe Cohort do
    let(:cohort) { Cohort.new }
    let(:conversion_data) { SpecData::PARSED_JSON_DATA_CONVERSION }
    let(:non_conversion_data) { SpecData::PARSED_JSON_DATA_NON_CONVERSION }

    it 'is instantiated with a 0 conversions' do
      expect(cohort.conversions).to be_zero
    end

    it 'is instantiated with a 0 non-conversions' do
      expect(cohort.non_conversions).to be_zero
    end

    it 'sums the conversions for a cohort' do
      cohort.tally_conversions(conversion_data)
      expect(cohort.conversions).to eq(1)
      expect(cohort.non_conversions).to be_zero
    end

    it 'sums the non-conversions for a cohort' do
      cohort.tally_conversions(non_conversion_data)
      expect(cohort.conversions).to be_zero
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
          expect(cohort.conversions).to eq(50)
        end
      end

      describe '#non-conversions' do
        it 'sets the number of non-conversions' do
          expect(cohort.non_conversions).to eq(100)
        end
      end

      context 'and calculating cohort statistics' do
        describe '#size' do
          it 'calculates the cohort size' do
            expect(cohort.size).to eq(150)
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
            expect(cohort.error_bars_helper).to eq("7.54%")
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
