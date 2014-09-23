require 'json'

class Respond
  attr_reader :responses

  def initialize(filename)
    file = File.read(filename)
    data = JSON.parse(file)
    extract_responses(data)
  end

  def with(response)
    @responses[response] || "Don't know what to say"
  end

  private

  def extract_responses(data)
    @responses = {}
    data.to_h.each do |key, value|
      @responses[key.to_sym] = value
    end
  end
end
