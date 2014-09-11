require_relative '../data_science'
require_relative '../stat_calculator'
require 'json'

describe Split_Test do
  before :all do
    @mock_json = "[{\"cohort\":\"B\",\"result\":1},{\"cohort\":\"B\",\"result\":0},{\"cohort\":\"A\",\"result\":0}]"
  end

  describe '#initialize' do
    it "accepts data with any number of cohorts" do
      mock_json = "[{\"cohort\":\"B\",\"result\":1},{\"cohort\":\"C\",\"result\":0},{\"cohort\":\"A\",\"result\":0}]"
      allow(File).to receive(:read).with('irrelevant_file_name').and_return(mock_json)

      unit_under_test = Split_Test.new('irrelevant_file_name')
      expect(unit_under_test.cohorts).to include(Cohort.new("A"))
      expect(unit_under_test.cohorts).to include(Cohort.new("B"))
      expect(unit_under_test.cohorts).to include(Cohort.new("C"))
    end
  end

  describe '#calculate_stats' do
    it "calculates conversion and standard error once for each cohort" do
      allow(File).to receive(:read).with('irrelevant_file_name').and_return(@mock_json)
      
      expect(Stat_Calculator).to receive(:conversion).twice
      expect(Stat_Calculator).to receive(:standard_error).twice

      unit_under_test = Split_Test.new('irrelevant_file_name')
      unit_under_test.calculate_stats
    end 

    it "calculates conversion and standard error based on given data" do
      allow(File).to receive(:read).with('irrelevant_file_name').and_return(@mock_json)

      expect(Stat_Calculator).to receive(:conversion).with(0,1).and_return(0)
      expect(Stat_Calculator).to receive(:conversion).with(1,2).and_return(0.5)
      expect(Stat_Calculator).to receive(:standard_error).with(0,1)
      expect(Stat_Calculator).to receive(:standard_error).with(0.5,2)

      unit_under_test = Split_Test.new('irrelevant_file_name')
      unit_under_test.calculate_stats
    end
  end

  describe '#output_stats' do
    it "calculates a chi square value for the test" do
      allow(File).to receive(:read).with('irrelevant_file_name').and_return(@mock_json)

      expect(Stat_Calculator).to receive(:chi_square).with(1,1,0,1)

      unit_under_test = Split_Test.new('irrelevant_file_name')
      unit_under_test.calculate_stats
      unit_under_test.output_stats
    end

    it "raises an exception if invoked without invoking calculate_stats" do
      allow(File).to receive(:read).with('irrelevant_file_name').and_return(@mock_json)

      unit_under_test = Split_Test.new('irrelevant_file_name')
      expect{unit_under_test.output_stats}.to raise_error(RuntimeError, "Must invoke calculate_stats before outputting them")
    end
      
  end

end
