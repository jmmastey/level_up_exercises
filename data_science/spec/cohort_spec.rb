require_relative '../data_science/cohort.rb'

RSpec.describe Cohort do
  before(:example) do
    @cohort = Cohort.new
  end

  def missed_result_entry
    { date: '2014-03-20', result: Cohort::MISSED_VAL }
  end

  def hit_result_entry
    { date: '2011-05-22', result: Cohort::HIT_VAL }
  end

  it 'initializes with empty data fields' do
    field_vals = @cohort.dates.size + @cohort.results.size + @cohort.result_val
    expect(field_vals).to eq(0)
  end

  context 'has hit result entry' do
    before(:example) do
      @cohort.insert hit_result_entry
    end

    it 'stores a result entrys date' do
      expect(@cohort.dates.size).to eq(1)
      expect(@cohort.dates.first).to eq(hit_result_entry[:date])
    end

    it 'stores a result entrys result' do
      expect(@cohort.results.size).to eq(1)
      expect(@cohort.results.first).to eq(hit_result_entry[:result])
    end

    it 'does increment result val on hit result entry' do
      expect(@cohort.result_val).to eq(Cohort::HIT_VAL)
    end
  end

  it 'does not increment result val on missed result entry' do
    @cohort.insert missed_result_entry
    expect(@cohort.result_val).to eq(Cohort::MISSED_VAL)
  end

  it 'updates to correct entry size' do
    @cohort.insert hit_result_entry
    @cohort.insert missed_result_entry
    expect(@cohort.num_entries).to eq(2)
  end

  it 'sums multiple result entries' do
    @cohort.insert missed_result_entry
    @cohort.insert hit_result_entry
    @cohort.insert missed_result_entry
    @cohort.insert hit_result_entry
    expect(@cohort.result_val).to eq(2)
  end
end
