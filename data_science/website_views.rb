require 'abanalyzer'
require_relative 'cohort.rb'
require_relative 'jsonparser.rb'

class WebsiteViews
  attr_reader :cohort_A, :cohort_B

  def initialize(input_file)
    data = JSONParser.read_data(input_file)
    data_A = data.select { |hash| hash['cohort'] == 'A' }
    data_B = data.select { |hash| hash['cohort'] == 'B' }
    @cohort_A = Cohort.new(data_A)
    @cohort_B = Cohort.new(data_B)
  end

  def chi_square
    {
      :agroup => { converted: cohort_A.conversions, bounced: cohort_A.bounced },
      :bgroup => { converted: cohort_B.conversions, bounced: cohort_B.bounced }
    }
  end

  def true_confidence_level?
    tester = ABAnalyzer::ABTest.new chi_square
    tester.different?
  end
end
