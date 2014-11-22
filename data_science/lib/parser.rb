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
    data.inject([]) { |memo, obj| memo << Visitor.new(obj) }
  end

  def self.seperate_into_cohorts(visitors)
    grouped = visitors.group_by(&:cohort)
    [build_cohort(grouped['A']), build_cohort(grouped['B'])]
  end

  def self.build_cohort(visitors)
    cohort = Cohort.new
    # REFACTOR
    visitors.each { |visitor| cohort.add(visitor) }
    cohort
  end
end
