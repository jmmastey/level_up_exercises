module FlightStats
  class UrlBuilder
    attr_accessor :from, :to, :date

    def from(value)
      @from = value
      self
    end

    def to(value)
      @to = value
      self
    end

    def date(value)
      @date = value
      self
    end

    def schedule_arriving_url
      validate_schedule_inputs
      "#{schedule_base_url}from/#{@from}/to/#{@to}/arriving/#{url_date(@date)}"
    end

    def schedule_departing_url
      validate_schedule_inputs
      "#{schedule_base_url}from/#{@from}/to/#{@to}/departing/#{url_date(@date)}"
    end

    private

    HOST            = "api.flightstats.com"
    API_VERSION     = "v1"

    def schedule_base_url
      "https://#{HOST}/flex/schedules/rest/#{API_VERSION}/json/"
    end

    def url_date(date)
      sprintf("%04d/%02d/%02d", date.year, date.month, date.day)
    end

    def validate_schedule_inputs
      raise(ArgumentError, "Missing to attr") if @to.nil? || @to.empty?
      raise(ArgumentError, "Missing from attr") if @from.nil? || @from.empty?
      raise(ArgumentError, "Missing date attr") if @date.nil?
    end
  end
end
