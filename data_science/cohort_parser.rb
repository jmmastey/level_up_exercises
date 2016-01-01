require 'pry'
class CohortParser
  attr_accessor :cohorts
  def initialize(raw_data)
    @raw_data = raw_data
    @cohorts = {"A" => {:hits => 0, :attempts => 0},
      "B" => {:hits => 0, :attempts => 0}}
  end

  def convert_to_cohorts
    @raw_data.each do |piece|
      @cohorts[piece["cohort"]][:attempts] += 1
      if(piece["result"] == 1)
        @cohorts[piece["cohort"]][:hits] += 1
      end
    end
    @cohorts
  end
end
