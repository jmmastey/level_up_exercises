require_relative 'calculator'

# I understand that chi_square of experiment is
# sum of chi_square of each cohort in a experiment
puts "The winner of the experiment is " + Calculator.new.winner

print "The total conversions of the experiment is "
puts Experiment.new("source_data.json").total_conversions.to_s

print "The expected conversions of the experiment is "
puts Experiment.new("source_data.json").expected_conversions

print "The total visits of the experiment is "
puts Experiment.new("source_data.json").total_visits.to_s
