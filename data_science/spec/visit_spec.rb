require 'spec_helper'
require_relative '../lib/visit'

describe Visit do
  let(:a_visit) { FactoryGirl.build(:visit) }
  it 'has a cohort' do
    expect(a_visit.cohort).to be_truthy
  end
end
