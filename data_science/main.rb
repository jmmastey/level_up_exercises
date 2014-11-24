#!/usr/bin/env ruby

require 'json'
require_relative 'ab_test.rb'

def usage
  puts "USAGE : #{$PROGRAM_NAME} JSON_FILE_NAME"
  exit
end

def help?
  ['-h', '--help', '--info'].include?(ARGV[0])
end

def error(message)
  $stderr.puts "#{$PROGRAM_NAME} - ERROR : #{message}"
end

def create_cohort(name, data)
  successes = data.count { |d| d['result'] == 1 }
  failures  = data.count { |d| d['result'] == 0 }
  Cohort.new(name, successes, failures)
end

def json_data_to_cohort_collection(json_data)
  grouped = json_data.group_by { |j| j['cohort'] }

  cohort_array = grouped.map do |cohort_name, data|
    create_cohort(cohort_name, data)
  end

  CohortCollection.new(cohort_array)
end

usage if ARGV.empty? || help?

begin
  json_data         = JSON.parse(File.read(ARGV[0]))
  cohort_collection = json_data_to_cohort_collection(json_data)
  puts ABTest.new(cohort_collection)
rescue JSON::ParserError
  error "Provided file is not a valid json file"
rescue SystemCallError => e
  error e.message
end
