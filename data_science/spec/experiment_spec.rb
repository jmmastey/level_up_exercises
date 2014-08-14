# File experiment_spec.rb
require 'rspec'
require './experiment'
require './cohort'

describe Experiment do
  let(:experiment){Experiment.new}
  let(:cohort_a){Cohort.new('A')}
  let(:cohort_b){Cohort.new('B')}
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
  it 'expect a standard error' do
    pending
  end


end