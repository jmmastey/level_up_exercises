require_relative "spec_helper"
require_relative "../load_json"
require_relative "../cohort_sorter"
require_relative "../cohort"

describe Cohort do
  let(:source_data) { LoadJSON.new("test_data.json").parse }
  let(:cohort_sorter) { CohortSorter.new(source_data) }
  subject(:cohort_a) do
    Cohort.new(cohort_sorter.sorted_visits_by_cohort[:A])
  end

  context 'with valid input data' do
    it "should have a size of the cohort" do
      expect(cohort_a.size).to be_a_kind_of(Fixnum)
    end

    it "should have a number of conversions in the cohort" do
      expect(cohort_a.conversions).to be_a_kind_of(Fixnum)
    end

    it "should have a number of failures in the cohort" do
      expect(cohort_a.failures).to be_a_kind_of(Fixnum)
    end

    it "should have a conversion percentage" do
      expect(cohort_a.conversion_percentage).to be_a_kind_of(Numeric)
    end

    it "should have a group name as a string" do
      expect(cohort_a.group_name).to be_a(String)
    end
  end

  context 'where cohort A is the winner' do
    it "should have a cohort size of 24" do
      expect(cohort_a.size).to be == 24
    end

    it "should have a group name of 'A'" do
      expect(cohort_a.group_name).to be == 'A'
    end

    it "should have a conversion percentage of 66.67" do
      expect(cohort_a.conversion_percentage).to be == 66.67
    end

    it "should have 16 conversions" do
      expect(cohort_a.conversions).to be == 16
    end

    it "should have 8 failures" do
      expect(cohort_a.failures).to be == 8
    end

  end
end
