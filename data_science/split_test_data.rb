require 'json'

class SplitTestData
  attr_reader :data

  def initialize(json_file)
    @data = JSON.parse(file_contents(json_file))
  end

  def file_contents(file_path)
    File.open(file_path, 'r') {|f| f.read }
  end

end