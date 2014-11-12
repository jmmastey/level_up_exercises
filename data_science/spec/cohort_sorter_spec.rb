require_relative "spec_helper"
require_relative "../load_json"
require_relative "../cohort_sorter"
require_relative "../cohort"

describe CohortSorter do
  context 'with valid test data' do
    let(:source_data) { LoadJSON.new("test_data.json").parse }
    subject(:cohort_sorter) { CohortSorter.new(source_data) }

    it "takes an array of visits" do
      expect(cohort_sorter.visits).to be_a(Array)
      expect(cohort_sorter.visits).not_to be_empty
    end

    it "should identify total number of visits as 48" do
      expect(cohort_sorter.visits.length).to be == 48
    end

    it "should identify cohort names from visits" do
      expect(cohort_sorter.cohort_groups).to be_a(Array)
      expect(cohort_sorter.cohort_groups).not_to be_empty
    end

    it "should have 2 cohort groups as A and B" do
      expect(cohort_sorter.cohort_groups).to be == %w(A B)
    end

    it "should have a cohort A with 24 visits" do
      expect(cohort_sorter.cohorts[:A].size).to be == 24
    end

    it "should have a cohort B with 24 visits" do
      expect(cohort_sorter.cohorts[:B].size).to be == 24
    end

    it "should sort visits by cohort to hash" do
      expect(cohort_sorter.cohorts).to be_a(Hash)
      expect(cohort_sorter.cohorts).not_to be_empty
    end

    it "should calculate cohort data" do
      expect(cohort_sorter.cohorts.first[1]).to be_an_instance_of(Cohort)
    end

    it "should return success failures for each cohort" do
      success_failures = cohort_sorter.success_failures

      expect(success_failures).to be_a(Hash)
      expect(success_failures).to have_key(:A)
      expect(success_failures).to have_key(:B)

    end

    it "should have total number of success failures equal to cohort size" do
      success_failures = cohort_sorter.success_failures
      total_a = success_failures[:A].reduce(0) { |total, val| total + val[1] }
      total_b = success_failures[:B].reduce(0) { |total, val| total + val[1] }

      expect(total_a).to be == 24
      expect(total_b).to be == 24
    end

  end
end
