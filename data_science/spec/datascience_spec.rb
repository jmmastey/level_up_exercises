load 'datascience.rb'
require 'spec_helper'
require 'rspec'

describe DataScience do
  let(:ds) { DataScience.new('sample.json') }

  describe 'When data science is validated' do
    describe '#cohort_count' do
      it 'Calculate sample size for each cohort' do
        expect(ds.cohort_count('A')).to eq(57)
        expect(ds.cohort_count('B')).to eq(61)
      end
    end
    describe '#conversion_count' do
      it 'Calculate conversion count for each cohort' do
        expect(ds.conversion_count('A')).to eq(6)
        expect(ds.conversion_count('B')).to eq(15)
      end
    end
    describe '#conversion_miss_count' do
      it 'Calculate conversion miss count for each cohort' do
        expect(ds.conversion_miss_count('A')).to eq(51)
        expect(ds.conversion_miss_count('B')).to eq(46)
      end
    end
    describe '#conversion_rate' do
      it 'Calculate conversion rate for each cohort' do
        expect(ds.conversion_rate('A')).to eq(0.1053)
        expect(ds.conversion_rate('B')).to eq(0.2459)
      end
    end
    describe '#distribution_limit' do
      it 'Calculate distribution limit for each cohort' do
        expect(ds.distribution_limit('A')).to match_array([0.005, 0.2056])
        expect(ds.distribution_limit('B')).to match_array([0.1896, 0.3022])
      end
    end
    describe '#chisquare_p' do
      it 'Calculate chisquare in sample size' do
        expect(ds.chisquare_p).to eq(0.9058)
      end
    end
    describe '#leader' do
      it 'Check who is leader' do
        expect(ds.leader).to eq('B')
      end
    end
  end
end
