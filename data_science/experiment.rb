require 'abanalyzer'
require_relative 'page_view.rb'
require_relative 'cohort.rb'

class Experiment
  CONFIDENCE_LEVEL      = 1.96 # why
  PROBABILITY_THRESHOLD = 0.05 # why

  def initialize(results)
    create_cohorts(pageviews(results))
    @test = ABAnalyzer::ABTest.new(format_for_abanalyzer)
  end

  # prints out the winner cohort (make a winner method)
  # if there's no winner you print out another message
  def report
    if winner
      winner.name
    else
      "There is no clear winner!"
    end
  end

  def winner
    @cohorts.sort_by(&:conversion_percentage).to_a.last if difference?
  end

  def difference?
    @test.chisquare_p <= PROBABILITY_THRESHOLD
  end

  private

  def pageviews(results)
    results.map { |result| PageView.new(result["cohort"], result["result"]) }
  end

  def create_cohorts(pageviews)
    @cohorts = []
    pageviews.group_by(&:cohort).each do |name, views|
      @cohorts << Cohort.new(name, views)
    end
  end

  def format_for_abanalyzer
    # [Cohort obj, Cohort obj]->{A:{success:30, failure:5}, B:{sucs:0, fail:30}}
    @cohorts.each_with_object({}) do |(cohort), hash|
      hash[cohort.name.to_sym] = { success: cohort.conversions, failure: cohort.rejections }
    end
  end
end
