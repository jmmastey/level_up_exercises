require_relative 'robo_researcher'

class DataScience
  def report
    data_file = "data_export_2014_06_20_15_59_02.json"
    researcher = RoboResearcher.new(data_file: data_file)
    puts "\n#{researcher.conclude}\n\n#{researcher.details}\n\n"
  end
end

DataScience.new.report
