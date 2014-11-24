require 'json'
require_relative 'cohort'

class Parser
  def parse(file)
    data = JSON.parse(File.read(file), symbolize_names: true)
    seperate_into_cohorts(create_visitors(data))
  end

  private

  Visitor = Struct.new(:visit_date, :cohort, :result) do
    def conversion?
      result == 1
    end
  end

  def create_visitors(data)
    data.map { |obj| Visitor.new(obj[:visit_date], obj[:cohort], obj[:result]) }
  end

  def seperate_into_cohorts(visitors)
    grouped = visitors.group_by(&:cohort)
    [Cohort.new(grouped['A']), Cohort.new(grouped['B'])]
  end
end
