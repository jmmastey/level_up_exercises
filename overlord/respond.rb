require 'json'

class Respond
  attr_reader :responses
  attr_reader :last

  DONT_KNOW = "Don't know what to say"

  def initialize(filename)
    file = File.read(filename)
    data = JSON.parse(file)
    extract_responses(data)
    @last = DONT_KNOW
  end

  def with(response)
    @last = @responses[response] || DONT_KNOW
  end

  private

  def extract_responses(data)
    @responses = {}
    data.to_h.each do |key, value|
      @responses[key.to_sym] = value
    end
  end
end
