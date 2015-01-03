require 'abanalyzer'
require_relative 'page_view.rb'
require_relative 'cohort.rb'


class Experiment

  CONFIDENCE_LEVEL      = 1.96
  PROBABILITY_THRESHOLD = 0.05

  def initialize(results)
    create_cohorts(pageviews(results))
    @test = ABAnalyzer::ABTest.new(format_for_abanalyzer)
  end

  def report
    if chisquare_p >= PROBABILITY_THRESHOLD
      "No clear winner"
    else
      "Winner: Cohort #{winning_cohort}"
    end
  end

  def chisquare_p
    @test.chisquare_p
  end

  def clear_difference?
    chisquare_p >= PROBABILITY_THRESHOLD
  end

  private

  def pageviews(results)
    results.map { |result| PageView.new(result["cohort"], result["result"]) }
  end

  def create_cohorts(pageviews)
    @cohorts = []
    pageviews.group_by(&:cohort).each do |c, v|
      @cohorts << Cohort.new(c, v)
    end
  end

  def format_for_abanalyzer
    # [Cohort obj, Cohort obj] --> {:A=>{:success=>30, :failure=>5}, :B=>{:success=>30, :failure=>30}}
    groups = {}
    @cohorts.each do |cohort|
      groups[cohort.name.to_sym] = { success: cohort.conversions, failure: cohort.rejections }
    end
    groups
  end

  def winning_cohort
    @cohorts.sort_by { |cohort| cohort.conversion_percentage }.to_a.last
  end


end