require_relative '../observation'

def observations(subject, successes, failures)
  result = []
  successes.times { result << Observation.new(subject, true) }
  failures.times { result << Observation.new(subject, false) }
  result
end
