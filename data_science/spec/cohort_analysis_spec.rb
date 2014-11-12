require_relative '../cohort_analysis'
require_relative '../cohort_sorter'

describe CohortAnalysis do

  context 'with winning input data' do
    subject(:cohort_analysis) { CohortAnalysis.new('test_data.json') }

    it 'should instantiate a CohortSorter with data from filenames' do
      expect(cohort_analysis.cohort_sorter).to be_an_instance_of(CohortSorter)
    end

    it 'should calculate a winner' do
      expect(cohort_analysis.winner).not_to be_empty
      expect(cohort_analysis.winner).to be_a_kind_of(String)
    end

    it 'should calculate the winner as A' do
      expect(cohort_analysis.winner).to be == "Group 'A' wins"
    end
  end

  context 'with non-winning input data' do
    subject(:cohort_analysis) do
      CohortAnalysis.new('test_data_nonwinning.json')
    end

    it 'should calculate the winner as no clear winner' do
      expect(cohort_analysis.winner).to be == "No clear winner"
    end
  end

  context 'with no filenames' do
    it 'should raise a runtime error' do
      expect { CohortAnalysis.new }.to raise_error
    end
  end
end
