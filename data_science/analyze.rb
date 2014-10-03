require_relative 'observation_json_parser'
require_relative 'confidence_report'

raise 'Needs Datafile' unless ARGV.count == 1

filename = ARGV[0]
parser = ObservationJSONParser.new(filename)

confidence = Confidence.new
confidence.add_list(parser.observations)

report = ConfidenceReport.new(confidence)
puts "\n#{report}\n\n"
