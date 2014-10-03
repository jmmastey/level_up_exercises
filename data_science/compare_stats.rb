require "abanalyzer"

class CompareStats
  def initialize(*data_stats)
    @data_stats = data_stats
  end

  def leader
    @data_stats.sort_by(&:conversion_percent).last
  end

  def significant_difference?
    probabilty_level < 0.05
  end

  def probabilty_level
    tester = ABAnalyzer::ABTest.new(stats_to_hash)
    tester.chisquare_p
  end

  private

  def stats_to_hash
    @data_stats.each_with_object({}) do |stat, hash|
      hash[stat.name] = {
        success: stat.conversions,
        failure: stat.sample_size - stat.conversions,
      }
    end
  end
end
