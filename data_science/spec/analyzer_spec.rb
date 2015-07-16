require_relative '../lib/analyzer'
require_relative '../lib/cohort_loader'

RSpec.describe Analyzer do
  let(:analyzer) do
    Analyzer.new(values)
  end

  let(:values) do
    loader = CohortLoader.new('spec/analyzer_data.json')
    loader.load

    values = {}
    values['A'] = {
      pass: loader.conversions('A'),
      fail: (loader.sample_size('A') - loader.conversions('A')),
    }

    values['B'] = {
      pass: loader.conversions('B'),
      fail: (loader.sample_size('B') - loader.conversions('B')),
    }

    values
  end

  let(:successful_analyzer) do
    pass_values = {}
    pass_values['A'] = {
      pass: 3,
      fail: 97,
    }
    pass_values['B'] = {
      pass: 10,
      fail: 90,
    }

    Analyzer.new(pass_values)
  end

  context '#new' do
    it 'should take in 1 argument representing group a and b' do
      expect { Analyzer.new }.to raise_error(ArgumentError)
      expect { Analyzer.new(values) }.not_to raise_error
    end
  end

  context '.winner?' do
    it 'should determine if there is a clear winner' do
      expect(successful_analyzer.winner?).to be true
      expect(analyzer.winner?).to be false
    end
  end
end
