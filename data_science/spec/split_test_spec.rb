require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe DataScience::SplitTest do
  describe '#new' do
    it 'takes two cohorts as parameters' do
      cohort_a = DataScience::Cohort.new('Cohort A')
      cohort_b = DataScience::Cohort.new('Cohort B')

      split_test = DataScience::SplitTest.new(cohort_a, cohort_b)
    end
  end
end