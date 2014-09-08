# File experiment_spec.rb
require 'rspec'
require './experiment'
require './cohort'

describe Experiment do
  let(:experiment) { Experiment.new }
  let(:cohort_a) { Cohort.new('A', visits: 1349.0, conversions: 47.0) }
  let(:cohort_b) { Cohort.new('B', visits: 1543.0, conversions: 79.0) }

  # subject{experiment}

  context '@confidence' do
    it 'expect 95%' do
      expect(experiment.confidence).to eq(0.95)
    end

  end

  context '@z_score' do
    it 'expect a z_score of 0.975' do
      expect(experiment.z_score).to eq(0.975)
    end

    it 'expect #cdf_inverse of about 1.96' do
      expect(experiment.cdf_inverse(experiment.z_score)).to be_within(0.01).of(1.96)
    end

    it 'expect #cdf of 0.975' do
      expect(experiment.cdf(experiment.cdf_inverse(experiment.z_score))).to be_within(0.001).of(0.975)
    end

  end
  context '#stadard_error' do
    it 'expect a standard error' do
      visits = 1000.0
      conversions = 100.0
      expect(experiment.standard_error((conversions / visits), visits)).to be_within(0.001).of(0.009)
    end
  end

  context '#chi_square_formulat' do
    it 'expect a value' do
      expect(experiment.chi_square_formula(cohort_a.visits, cohort_b.visits, cohort_a.conversions, cohort_b.conversions)).to eq(4.241)
    end

  end

end
