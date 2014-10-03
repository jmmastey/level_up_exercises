require_relative 'observation_json_parser'
require_relative 'confidence_report'

raise 'Needs Datafile' unless ARGV.count == 1

confidence = Confidence.new

filename = ARGV[0]
parser = ObservationJSONParser.new(filename)
parser.apply(confidence)

report = ConfidenceReport.new(confidence)
puts "\n#{report}\n\n"
