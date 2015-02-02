class WeatherConditionsParameter
  attr_reader :coverages,
              :intensities,
              :weather_types,
              :qualifiers,
              :additives
              
  def initialize(weather_condition)
    @coverages = get_value(weather_condition, :@coverage)
    @intensities = get_value(weather_condition, :@intensity)
    @weather_types = get_value(weather_condition, :@weather_type)
    @qualifiers = get_value(weather_condition, :@qualifier)
    @additives = get_value(weather_condition, :@additive)
  end

  private

  def get_value(weather_condition, key)
    return nil if weather_condition.nil?
    if weather_condition.kind_of?(Array)
      weather_condition.each_with_object([]) { |wc, final| final << wc[key] }
    else
      weather_condition[key]
    end
  end
end