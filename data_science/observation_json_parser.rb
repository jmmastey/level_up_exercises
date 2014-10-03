require 'json'
require_relative 'observation'
require_relative 'confidence'

class ObservationJSONParser
  def initialize(filename)
    file = File.read(filename)
    @data = JSON.parse(file)
  end

  def observations
    @data.map { |entry| to_observation(entry) }.compact
  end

  private

  def to_observation(entry)
    subject = entry['cohort']
    success = entry['result']
    return nil if subject.nil? || success.nil?
    Observation.new(subject, success.to_i == 1)
  end
end
