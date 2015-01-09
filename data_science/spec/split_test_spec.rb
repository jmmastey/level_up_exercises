require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe DataScience::SplitTest do
  let (:split_test) do
    cohort_a, cohort_b = load_cohort_data
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
    cohort_a = DataScience::Cohort.new('Cohort A')
    cohort_b = DataScience::Cohort.new('Cohort B')

    raw_data = File.read(File.expand_path("data/source_data.json"))
    json     = JSON.parse(raw_data)

    json.each do |current_sample|
      if current_sample['cohort'] == 'A'
        cohort_a.add_sample(current_sample['result'])
      elsif current_sample['cohort'] == 'B'
        cohort_b.add_sample(current_sample['result'])
      end
    end

    [cohort_a, cohort_b]
  end
end
