#!/usr/bin/env ruby
# File data_science.rb
require 'json'
require './cohort'
require './experiment'
DataEntry = Struct.new(:date, :cohort, :result) do
  def to_s
    "#{date} #{cohort} #{result}"
  end
end

class DataScience
  attr_accessor :group_a, :group_b

  def initialize(confidence=95.0, *groups)
    experiment = Experiment.new(confidence)
    groups.each do |group|
        self.group_a ||= group
        self.group_b ||= group
    end
  end
end
class LoadJson
  attr_accessor :data, :group_a, :group_b, :cohorts

  def initialize(filename)
    @data = []
    @group_a = []
    @group_b = []
    self.cohorts = []
    f = File.read(filename)
    json = JSON.parse(f, {:symbolize_names => true})
    process_json(json)
    self
  end

  private
  def process_json(json)
    json.each do |entry|
      row = DataEntry.new(entry['date'], entry['cohort'], entry['result'] )
      @data << row
      co = get_or_create_cohort(row.cohort)
      co.add_visit
      co.add_conversion if row.result == 1
    end
  end

  def get_or_create_cohort(name)
    cohort = nil
    self.cohorts.each do |co|
      cohort = co if co.name == name
    end
    unless cohort
      cohort = Cohort.new(name)
      self.cohorts << cohort
    end
    cohort
  end
end


jsondata = LoadJson.new('source_data.json')
science = DataScience.new(jsondata.cohorts)
puts science.visitor_count
puts science.group_conversions(science.group_a)
puts science.group_conversions(science.group_b)