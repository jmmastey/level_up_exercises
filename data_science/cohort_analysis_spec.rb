require_relative 'spec/spec_helper'
require_relative 'cohort_analysis'

describe CohortAnalysis do
  let(:cohort_analysis) { CohortAnalysis.new }
  context '#name' do
    it 'has a name attribute of Tyler' do


      expect(cohort_analysis.name).to eq('Tyler')
    end

end
