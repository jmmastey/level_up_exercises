require_relative '../data_science/data_science.rb'

RSpec.describe DataScience do
  TEST_JSON_PATH = 'split_data/test_data.json'
  NUM_TEST_ENTRIES_TOTAL = 40
  NUM_TEST_ENTRIES_A = 20
  NUM_TEST_ENTRIES_B = NUM_TEST_ENTRIES_TOTAL - NUM_TEST_ENTRIES_A
  COHORT_NAME_A = 'A'
  COHORT_NAME_B = 'B'

  before(:example) do
    @data_science = DataScience.new(COHORT_NAME_A, COHORT_NAME_B)
  end

  def cohort_entry(cohort_name)
    { cohort: cohort_name, date: '2014-05-10', result: 1 }
  end

  it 'can load an entry into cohort A' do
    @data_science.add_cohort_entry cohort_entry(COHORT_NAME_A)
    expect(@data_science.cohort_a.num_entries).to eq(1)
    expect(@data_science.cohort_b.num_entries).to eq(0)
  end

  it 'can load an entry into cohort B' do
    @data_science.add_cohort_entry cohort_entry(COHORT_NAME_B)
    expect(@data_science.cohort_b.num_entries).to eq(1)
    expect(@data_science.cohort_a.num_entries).to eq(0)
  end

  context 'has loaded test json' do
    before(:example) do
      @data_science.load_cohort_json TEST_JSON_PATH
    end

    it 'laods correct num of entries from json file' do
      expect(@data_science.sample_size).to eq(NUM_TEST_ENTRIES_TOTAL)
    end

    it 'laods correct num of entries from json file into A cohort' do
      expect(@data_science.cohort_a.num_entries).to eq(NUM_TEST_ENTRIES_A)
    end

    it 'laods correct num of entries from json file into B cohort' do
      expect(@data_science.cohort_b.num_entries).to eq(NUM_TEST_ENTRIES_B)
    end

    it 'can calculate cohort A conversion rate' do
      rate = @data_science.cohort_a_conversion_rate
      min = rate[0].round(3)
      max = rate[1].round(3)
      expect(min).to eq(0.025)
      expect(max).to eq(0.375)
    end

    it 'can calculate cohort B conversion rate' do
      rate = @data_science.cohort_b_conversion_rate
      min = rate[0].round(3)
      max = rate[1].round(3)
      expect(min).to eq(0.141)
      expect(max).to eq(0.559)
    end
  end

  it 'can calculate cohort leader confidence' do
    @data_science.load_cohort_json
    expect(@data_science.cohort_leader_confidence).to eq(1.0)
  end
end
