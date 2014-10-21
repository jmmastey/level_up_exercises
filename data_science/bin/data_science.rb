#!/usr/bin/ruby -w

require "json"
require_relative "../lib/ab_test"

def select_group(cohort, ab_test)
  case cohort
    when 'A' then  ab_test.group_a
    when 'B' then  ab_test.group_b
    else raise "Failed sample: unknown cohort: #{cohort}"
  end
end

def select_message(result)
  case result
    when 0 then :add_converts
    when 1 then :add_nonconverts
    else raise "Failed sample: unknown outcome: #{result}"
  end
end

ab_test = ABTest.new
failed_samples = 0
source_data = ARGV[0] || begin
  STDERR << "Missing JSON input file\n"
  exit(1)
end

JSON.load(File.open(source_data)).each do |sample|
  begin
    group = select_group(sample['cohort'], ab_test)
    message = select_message(sample['result'])
    group.send(message, 1)
  rescue => ex
    puts ex
    failed_samples += 1
  end
end

puts ab_test.to_text, "\n"
