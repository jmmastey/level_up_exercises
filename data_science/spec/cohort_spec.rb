# File cohort_spec.rb
require 'rspec'
require './spec/spec_helper'
require './cohort'

fields = [:visits, :conversions]
describe Cohort do
  let(:cohort) { Cohort.new('A') }
  subject { cohort }

  it 'name should be A' do
    expect(cohort.name).to eq('A')
  end

  context 'have no' do
    fields.each do |_field|

    end
    it '@visits' do
      expect(cohort.visits).to be(0.0)
    end

    it '@conversions' do
      expect(cohort.conversions).to be(0.0)
    end
  end

  context '#adds' do

    fields.each do |field|
      it "@#{field}" do
        m = cohort.method("add_#{field}")
        expect { m.call }.to change { cohort.method(field).call }.from(0.0).to(1.0)
      end
    end
  end

  context '#conversion_rate' do
    before { cohort.visits = 0.0 }
    before { cohort.conversions = 0.0 }

    it 'is not a number' do
      expect(cohort.conversion_rate.to_s).to eq 'NaN'
    end

    it 'is one' do
      # Cohort.stub(:conversion_rate).returns(stub(1))
      cohort.visits = 1.0
      cohort.conversions = 1.0
      expect(cohort.conversion_rate).to be_an_instance_of(Float).and eq(1.0)
    end

  end
end
