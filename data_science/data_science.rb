#!/usr/bin/env ruby
# File data_science.rb
require './load_json'
require './cohort'
require './experiment'

class DataScience
  attr_accessor :group_a, :group_b

  def initialize(confidence = 95.0, groups = [])
    experiment = Experiment.new(confidence)
    groups.each do |group|
      self.group_a ||= group if group.name == 'A'
      self.group_b ||= group if group.name == 'B'
    end
    puts experiment.analyse(groups)
  end
end

jsondata = LoadJson.new('source_data.json')
DataScience.new(95.0, jsondata.cohorts)
