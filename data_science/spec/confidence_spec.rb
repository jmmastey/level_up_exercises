require 'spec_helper'
require 'data_helper'
require_relative '../confidence'

describe Confidence do
  let(:confidence) do
    confidence = Confidence.new
    4.times { confidence.add(Observation.new('A', true )) }
    4.times { confidence.add(Observation.new('A', false)) }
    9.times { confidence.add(Observation.new('B', true )) }
    7.times { confidence.add(Observation.new('B', false)) }
    confidence
  end

  let(:confidence_from_list) do
    confidence_from_list = Confidence.new
    confidence_from_list.add_list(observations('A', 4, 4))
    confidence_from_list.add_list(observations('B', 9, 7))
    confidence_from_list
  end

  let(:interval_a) { confidence.interval('A') }
  let(:interval_b) { confidence.interval('B') }

  let(:a_lower) { 0.5 - 0.3535533906 }
  let(:a_upper) { 0.5 + 0.3535533906 }
  let(:a_midpt) { 0.5 }

  let(:b_lower) { 0.5625 - 0.2480391854 }
  let(:b_upper) { 0.5625 + 0.2480391854 }
  let(:b_midpt) { 0.5625 }

  it 'contains the correct list of subjects' do
    expect(confidence.subjects).to match_array(["A", "B"])
  end

  it 'adds observations correctly' do
    expect(confidence.subjects).to match_array(["A", "B"])
  end

  it 'adds observations from a list correctly' do
    expect(confidence_from_list.subjects).to match_array(["A", "B"])
  end

  it 'computes the confidence interval for A correctly' do
    expect(interval_a.lower).to be_within(an_angstrom).of(a_lower)
    expect(interval_a.upper).to be_within(an_angstrom).of(a_upper)
    expect(interval_a.midpt).to be_within(an_angstrom).of(a_midpt)
  end

  it 'computes the confidence interval for B correctly' do
    expect(interval_b.lower).to be_within(an_angstrom).of(b_lower)
    expect(interval_b.upper).to be_within(an_angstrom).of(b_upper)
    expect(interval_b.midpt).to be_within(an_angstrom).of(b_midpt)
  end

  it 'computes the max-cohort correctly' do
    expect(confidence.max_subject).to eq('B')
    expect(confidence.max_conversion).to be_within(an_angstrom).of(0.5625)
    expect(confidence.is_max?('B')).to be true
  end

  it 'does not have distinct means' do
    expect(confidence).not_to have_distinct_means
  end

  it 'has correct chi-square value' do
    expect(confidence.chi_square_value).to be_within(an_angstrom).of(0.0839160839)
  end

  it 'has correct chi-square significance' do
    expect(confidence.chi_square_significance).to be_within(an_angstrom).of(0.2279410302)
  end
end
