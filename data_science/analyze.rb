require './observation_json_parser'

if ARGV.count != 1
  $stderr.puts 'Needs DataFile'
  exit
end

confidence = Confidence.new

filename = ARGV[0]
parser = ObservationJSONParser.new(filename)
parser.apply(confidence)

puts "\n#{confidence.report}\n\n"
