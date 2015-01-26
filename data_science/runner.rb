require_relative 'calculator'

# The way that I understand is chi_square of experiment is
# sum of chi_square of each cohort in a experiment.
# Most of the stuff I borrowed from http://www.wikihow.com/Calculate-P-Value

puts "The winner of the experiment is " + Calculator.new.winner

print "The total conversions of the experiment is "
puts Experiment.new("source_data.json").total_conversions.to_s

print "The expected conversions of the experiment is "
puts Experiment.new("source_data.json").expected_conversions

print "The chi_square for cohorts is "
puts Calculator.new.chi_squared_for_experiments.to_s

print "The total chi_square for experiments is "
puts Calculator.new.chi_square.to_s

print "The total visits of the experiment is "
puts Experiment.new("source_data.json").total_visits.to_s

print "The winner experiment is "
puts Calculator.new.winner

if Calculator.new.significant?
  puts "As more than 5% of data is result is by chance we don't have a clear winner "
else
  print "As less than 5% of data is result is by chance we have a clear winner "
  puts Calculator.new.winner
end
