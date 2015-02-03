require './app/helpers/private_attr_accessor'
require './app/models/parameters/temperature_type_parameter'

class TemperatureParameter
  extend PrivateAttrAccessor
  private_attr_accessor :temperature
  attr_reader :maxt, :mint
  MAXT_NAME = "Daily Maximum Temperature"
  MINT_NAME = "Daily Minimum Temperature"

  def initialize(new_temperature)
    self.temperature = new_temperature
  end

  def maxt
    temperature_type_builder.new(maxt_attrs)
  end

  def mint
    temperature_type_builder.new(mint_attrs)
  end

  private

  def maxt_attrs
    temperature.select { |key| key[:name] == MAXT_NAME }.first
  end

  def mint_attrs
    temperature.select { |key| key[:name] == MINT_NAME }.first
  end

  def temperature_type_builder
    TemperatureTypeParameter
  end
end
