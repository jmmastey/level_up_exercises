load 'cohort.rb'
require 'spec_helper'
require 'rspec'

describe Cohort do
  cohort = {}
  cohort['date'] = '2014-03-20'
  cohort['cohort'] = 'B'
  cohort['result'] = 0

  let(:cohortobj) { Cohort.new(cohort) }

  context ' when check object' do
    it 'check date' do
      expect(cohortobj.date).to eq('2014-03-20')
    end
    it 'check cohort name' do
      expect(cohortobj.name).to eq('B')
    end
    it 'check result' do
      expect(cohortobj.result).to eq(0)
    end
  end
end
