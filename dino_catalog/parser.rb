require "CSV"

class Parser
  attr_accessor :headers, :content, :file

  def initialize(filepath)
    @file = filepath
    @file += '.csv' unless filepath =~ /\.csv$/
    @content = []
  end

  def parse
    lines = load_lines_and_process_headers
    load_content(lines)
    content
  end

  private

  def load_lines_and_process_headers
    lines = CSV.read(file)
    @headers = lines.shift.each(&:downcase!)
    lines
  end

  def load_content(lines)
    lines.each do |line|
      object = {}
      line.each_with_index do |value, index|
        object[headers[index]] = value
      end
      content << object
    end
  end
end
