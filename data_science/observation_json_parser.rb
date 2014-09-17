require 'json'
require './observation'
require './confidence'

class ObservationJSONParser
  def initialize(filename)
    file = File.read(filename)
    @data = JSON.parse(file)
  rescue
    puts "There was a problem reading the file: #{filename}"
  end

  def apply(confidence)
    @data.each do |entry|
      observation = to_observation(entry)
      confidence.add(observation) unless observation.nil?
    end
  end

  private

  def to_observation(entry)
    subject = entry['cohort']
    success = entry['result']
    return nil if subject.nil? || success.nil?
    Observation.new(subject, success.to_i == 1)
  end
end
