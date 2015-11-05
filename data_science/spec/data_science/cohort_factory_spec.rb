require 'data_science/cohort_factory'
require 'data_science/cohort'

describe DataScience::CohortFactory do
  class DataScience::Cohort
    def eql?(other)
      to_h == other.to_h
    end
  end

  let(:factory) { DataScience::CohortFactory.new }

  let(:cohort_json_array) do
    [ build(:cohort_json), build(:b_cohort_json), build(:converted_cohort_json) ]
  end

  it 'groups by cohort' do
    expect(factory.from_hash_array(cohort_json_array).keys).to eql [:A, :B]
  end

  it 'aggregates to one metadata object per cohort' do
    cohort_hash = factory.from_hash_array(cohort_json_array)

    expect(cohort_hash[:A].size).to equal 2
    expect(cohort_hash[:B].size).to equal 1
  end

  it 'provides the conversions' do
    cohort_hash = factory.from_hash_array(cohort_json_array)

    expect(cohort_hash[:A].yes).to equal 1
    expect(cohort_hash[:B].yes).to equal 0
  end

  it 'provides the non-conversions' do
    cohort_hash = factory.from_hash_array(cohort_json_array)

    expect(cohort_hash[:A].no).to equal 1
    expect(cohort_hash[:B].no).to equal 1
  end
end
