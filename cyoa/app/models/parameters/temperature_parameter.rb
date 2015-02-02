require './app/helpers/private_attr_accessor'
require './app/models/parameters/temperature_type_parameter'

class TemperatureParameter
  extend PrivateAttrAccessor
  private_attr_accessor :temperature
  attr_reader :maxt, :mint
  MAXT_NAME = "Daily Maximum Temperature"
  MINT_NAME = "Daily Minimum Temperature"

  def initialize(new_temperature)
    temperature = new_temperature
  end

  def maxt
    TemperatureTypeParameter.new(maxt_attrs)
  end

  def mint
    TemperatureTypeParameter.new(mint_attrs)
  end

  private

  def maxt_attrs
    temperature.select { |key| key[:name] == MAXT_NAME }.first
  end

  def mint_attrs
    temperature.select { |key| key[:name] == MINT_NAME }.first
  end
end
