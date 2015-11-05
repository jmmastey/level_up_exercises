require 'data_science/base'

# These tests are a little bit brittle.  Given that they are not expected
# to change very often, this is probably okay.  But if we find that these
# tests are breaking often and are negatively influencing development,
# then they should probably be removed and handled via functional tests
describe DataScience::Base do
  let(:base) { DataScience::Base.new }

  let(:cohort_factory) { double }
  let(:ab_test) { double }
  let(:mocked_base) { DataScience::Base.new(cohort_factory, ab_test) }

  let(:filename) { :filename }
  let(:file_data) { :file_data }
  let(:cohorts) { { A: :cohort_a, B: :cohort_b} }

  it 'reads from the file and passes the data to be processed' do
    expect_file_to_be_read
    expect(cohort_factory).to receive(:from_hash_array).with(file_data) { cohorts }
    expect(ab_test).to receive(:parse_test_results).with(:cohort_a, :cohort_b) { :result }

    expect(mocked_base.parse_test_results(filename)).to equal :result
  end

  it 'uses CohortFactory by default' do
    expect(base.instance_variable_get(:@cohort_factory)).to be_kind_of DataScience::CohortFactory
  end

  it 'uses ABTest by default' do
    expect(base.instance_variable_get(:@ab_test)).to be_kind_of DataScience::ABTest
  end

  private

  def expect_file_to_be_read
    expect(File).to receive(:read).with(filename) { :file_json_data }
    expect(JSON).to receive(:parse).with(:file_json_data, symbolize_names: true) { file_data }
  end
end
