require './service/json_parser.rb'

module Model
  class Datum
    attr_accessor :cohort, :date, :result

    def initialize(cohort, date, result)
      @cohort = cohort
      @date = date
      @result = result
    end

    def self.process_json(file)
      json = Service::JsonParser.parse(file)
      json.map { |j| new(j[:cohort], j[:date], j[:result]) }
    end
  end
end
