require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe DataScience::SplitTest do
  let (:split_test) do
    cohort_a, cohort_b  = load_cohort_data
    DataScience::SplitTest.new(cohort_a, cohort_b)
  end

  describe '#new' do
    it 'takes two cohorts as parameters' do
      expect(split_test).to be_a DataScience::SplitTest
    end
  end

  describe '#different?' do
    it 'returns true if the cohorts are significantly different' do
      expect(split_test).to be_different
    end
  end

  describe '#chisquare_p_value' do
    it 'returns the chisquare_p_value for the cohorts' do
      expect(split_test.chisquare_p_value).to eq(0.039)
    end
  end

  private

  def load_cohort_data
    cohorts = {
      'A' => DataScience::Cohort.new('Cohort A'),
      'B' => DataScience::Cohort.new('Cohort B')
    }

    raw_data = File.read(File.expand_path("data/source_data.json"))
    json     = JSON.parse(raw_data)

    json.each do |current_sample|
      cohorts[current_sample['cohort']].add_sample(current_sample['result'])
    end

    [cohorts['A'], cohorts['B']]
  end
end
