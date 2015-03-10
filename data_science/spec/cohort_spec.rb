load 'cohort.rb'
require 'spec_helper'
require 'rspec'

describe Cohort do
  let(:cohort) do
    Cohort.new('date' => '2014-03-20', 'cohort' => 'B', 'result' => 0)
  end
  context ' when check object' do
    it 'check date' do
      expect(cohort.date).to eq('2014-03-20')
    end
    it 'check cohort name' do
      expect(cohort.name).to eq('B')
    end
    it 'check result' do
      expect(cohort.result).to eq(0)
    end
  end
end
