require 'abanalyzer'
require 'cohort'

class ABTester
  attr_reader :groups

  def initialize(args)
    groups = make_groups(args)
    @groups = groups.reduce({}, :merge)
  end

  def calculate_better_than_random
    ABAnalyzer::ABTest.new(@groups).different?
  end

  private

  def make_groups(groups)
    data_groups = []
    groups.each do |item|
      data_groups << item.data
    end
    data_groups
  end
end
