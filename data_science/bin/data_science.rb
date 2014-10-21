#!/usr/bin/ruby -w

require "json"
require_relative "../lib/ab_test"

def err_quit(message, exitcode = 1)
  STDERR << message
  STDERR << "\n"
  exit(exitcode)
end

def select_group(cohort, ab_test)
  case cohort 
    when 'A' then  ab_test.group_A
    when 'B' then  ab_test.group_B
    else raise "Failed sample: unknown cohort: #{cohort}"
  end
end

def select_message(result, ab_test)
  case result
  when 0 then :add_converts
  when 1 then :add_nonconverts
  else raise "Failed sample: unknown outcome: #{result}"
  end
end

def print_test_group(group, group_name)
  ci = group.confidence_interval_95
  printf_args = [group.conversion_ratio, group.standard_error,
                 group.error_margin, ci.begin, ci.end]

  printf <<EOH, *printf_args
---- Group #{group_name} ---------------------
Visitors:         #{group.visitors}
Conversions:      #{group.converts}
Conversion ratio: %0.4f
Standard Error:   %0.4f
Error Margin:     %0.4f (%0.4f - %0.4f)

EOH
end

ab_test = ABTest.new
failed_samples = 0
source_data = ARGV[0] || err_quit("Missing JSON input file")

JSON.load(File.open(source_data)).each do |sample|
  begin
    group = select_group(sample['cohort'], ab_test)
    message = select_message(sample['result'], ab_test)
    group.send(message, 1)
  rescue => ex
    puts ex
    failed_samples += 1
  end
end

print_test_group(ab_test.group_A, 'A')
print_test_group(ab_test.group_B, 'B')
significance = 
  ab_test.significant_95_confidence ? "SIGNIFICANT" : "Insignificant"
printf <<EOH, ab_test.chi_square_value, significance
---- CONCLUSION (95%% confidence criterion) ----
Chi-Square vale:          %0.4f
Statistical significance: %s
EOH
