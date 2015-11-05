require 'data_science/cohort'

describe DataScience::Cohort do
  let(:cohort) { build(:cohort, no: 100, yes: 900) }

  it 'provides the total size' do
    expect(cohort.size).to eq 1000
  end

  it 'is hashable' do
    expected_value = { no: 100, yes: 900 }
    expect(cohort.to_h).to eq expected_value
  end
end
