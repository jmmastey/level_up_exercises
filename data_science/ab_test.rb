require 'statistics2/no_ext'
require_relative 'cohort'
require_relative 'cohort_collection'

# InvalidABMatrixError = Class.new(StandardError)

class ABTest
  SEPARATOR = '-' * 100

  def initialize(cohort_collection)
    @cohort_collection = cohort_collection
  end

  def chi_squared
    @cohort_collection.chi_squared
  end

  def confidence_level
    Statistics2.chi2dist(1, chi_squared).round(4)
  end

  def significant?(confidence = 0.90)
    chi_squared > Statistics2.pchi2dist(1, confidence)
  end

  def to_s
    "#{SEPARATOR}\n#{@cohort_collection}\n#{SEPARATOR}\n#{decision}\n"
  end

  private

  def decision(threshold = 0.90)
    leader = @cohort_collection.leader

    if significant?(threshold)
      "Leader is #{leader} at #{confidence_level * 100}% confidence level"
    else
      "No clear leader at #{threshold * 100}% confidence level"
    end
  end
end
