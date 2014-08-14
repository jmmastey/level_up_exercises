# File cohort_spec.rb
require './spec/spec_helper'
# require 'rspec/its'

require './cohort'
fields = [:visits, :conversions]
describe Cohort do
  let(:cohort) {Cohort.new('A')}
  subject {cohort}

  it 'name should be A' do
    expect(cohort.name).to eq('A')
  end

  context 'have no' do
    fields.each do |field|

    end
    it 'visits' do
      expect(cohort.visits).to be(0)
    end

    it 'conversions' do
      expect(cohort.conversions).to be(0)
    end
  end

  context 'adds' do

    fields.each do |field|
      it field.to_s do
        m = cohort.method("add_#{field}")
        expect {m.call}.to change {cohort.method(field).call}.from(0).to(1)
      end
    end
  end
end