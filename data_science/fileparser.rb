require 'json'
require_relative 'cohort.rb'

class FileParser
  def self.parse_data(filename)
    if File.exist?(filename)
      rows = JSON.parse(File.read(filename))
      rows.map { |row| Cohort.new(row) }
    else
      fail('File not found')
    end
  end
end
