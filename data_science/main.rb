#!/usr/bin/env ruby

require 'json'
require_relative 'ab_test.rb'

def print_usage
  puts "USAGE : #{$PROGRAM_NAME} JSON_FILE_NAME"
  exit
end

def help?
  ['-h', '--help', '--info'].include?(ARGV[0])
end

def print_error(message)
  $stderr.puts "#{$PROGRAM_NAME} - ERROR : #{message}"
end

def data_count_by_result(cohort_data)
  {
    success: cohort_data.count { |cd| cd['result'] == 1 },
    failure: cohort_data.count { |cd| cd['result'] == 0 },
  }
end

def data_to_ab_test_matrix(data)
  data.group_by { |d| d['cohort'] }
    .each_with_object({}) do |(name, cohort_data), hash|
      hash[name] = data_count_by_result(cohort_data)
    end
end

print_usage if ARGV.empty? || help?

begin
  data   = JSON.parse(File.read(ARGV[0]))
  matrix = data_to_ab_test_matrix(data)
  puts ABTest.new(matrix)
rescue JSON::ParserError
  print_error "Provided file is not a valid json file"
rescue SystemCallError => e
  print_error e.message
end
