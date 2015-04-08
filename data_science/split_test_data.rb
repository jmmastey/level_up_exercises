require 'json'

class SplitTestData
  attr_reader :data

  def initialize(json_file)
    @data = JSON.parse(file_contents(json_file))
  end

  def data_summary
    Hash.new.tap do |data_summary|
      @data.each do |row|
        data_summary[row["cohort"]] += row[result]
        data_summary["#{row["cohort"]}_attempts"] += 1
      end
    end
  end

  private

  def file_contents(file_path)
    File.open(file_path, 'r') {|f| f.read }
  end
end