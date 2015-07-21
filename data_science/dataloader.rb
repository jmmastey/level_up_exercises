require 'json'
require_relative 'cohort'

module DataLoader
  def parse_json(filename)
    data = JSON.parse(File.read(filename))
    cohort_data = data.group_by { |r| r["cohort"] }
    cohort_data.each do |k,v|
      cohort_data[k] = v.map { |r| r["result"] }
    end
    cohort_data
  end

  def load_json(filename)
    cohorts = {}
    cohort_data = parse_json(filename)
    cohort_data.each do |k,v|
      cohorts[k] = Cohort.new(k, v)
    end
    cohorts
  end
end