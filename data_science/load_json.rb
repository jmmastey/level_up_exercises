# File load_json.rb
require 'json'
require './cohort'

DataEntry = Struct.new(:date, :cohort, :result) do
  def to_s
    "#{date} #{cohort} #{result}"
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
    json = JSON.parse(f, symbolize_names: true)
    process_json(json)
    self
  end

  private

  def process_json(json)
    json.each do |entry|
      row = DataEntry.new(entry[:date], entry[:cohort], entry[:result])
      @data << row
      co = get_or_create_cohort(row.cohort)
      co.add_visits
      co.add_conversions if row.result == 1
    end
  end

  def get_or_create_cohort(name)
    cohort = nil
    cohorts.each do |co|
      cohort = co if co.name == name
    end
    unless cohort
      cohort = Cohort.new(name)
      cohorts << cohort
    end
    cohort
  end
end
