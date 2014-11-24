require 'json'
require_relative 'visitor'
require_relative 'cohort'

module Parser
  def self.parse(file)
    data = JSON.parse(File.read(file), symbolize_names: true)
    seperate_into_cohorts(create_visitors(data))
  end

  private

  def self.create_visitors(data)
    data.map { |obj| Visitor.new(obj) }
  end

  def self.seperate_into_cohorts(visitors)
    grouped = visitors.group_by(&:cohort)
    [Cohort.new(grouped['A']), Cohort.new(grouped['B'])]
  end
end
