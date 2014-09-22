require_relative 'observation_json_parser'

raise 'Needs Datafile' unless ARGV.count == 1

confidence = Confidence.new

filename = ARGV[0]
parser = ObservationJSONParser.new(filename)
parser.apply(confidence)

puts "\n#{confidence.report}\n\n"
