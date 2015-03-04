require_relative 'parser'
require 'pry'

class Sample
  attr_accessor :cohort, :date, :result

  def initialize(row)
    @cohort = row['cohort']
    @date = row['date']
    @result = row['result']
  end

  def self.create_cohort(input)
    rows = Parser.new(input).parse
    rows.map{ |row| Sample.new(row)}
  end
end

