require_relative "data_stats"
require "json"

class LoadJsonStats
  def self.get_data_stats(file_path)
    file = File.open(file_path)
    data = JSON.load(file)
    cohorts = data.group_by { |d| d["cohort"] }
    count_cohorts(cohorts)
  end

  def self.count_cohorts(cohorts)
    cohorts.map do |cohort, data|
      total = data.length
      conversions = data.count { |d| d["result"] == 1 }
      DataStats.new(cohort, total, conversions)
    end
  end
end
