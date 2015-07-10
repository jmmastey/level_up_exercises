require "CSV"

class Parser
  attr_accessor :headers, :content, :file

  def initialize(filepath)
    @file = filepath
    @file += '.csv' unless filepath =~ /\.csv$/
    @content = {}
  end

  def parse
    lines = load_lines_and_process_headers
    load_content(lines)
    content
  end

  private

  def load_lines_and_process_headers
    lines = CSV.read(file)
    @headers = lines.shift
    lines
  end

  def load_content(lines)
    lines.each do |line|
      line.each_with_index do |value, index|
        content[headers[index]] = value
      end
    end
  end
end
