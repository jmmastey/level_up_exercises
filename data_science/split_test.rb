require_relative 'load_data.rb'
require 'abanalyzer'

# This class is used to define errors for invalid cohorts
class InvalidCohortError < RuntimeError
  def message
    'This cohort does not contain results of 0 or 1 so it is invalid'
  end
end

# This class is used for a Split test
class SplitTestAB
  CONV_FACTOR = 0.95
  attr_accessor :json_data
  attr_accessor :conversiona
  attr_accessor :conversionb
  attr_accessor :nonconversiona
  attr_accessor :nonconversionb
  attr_accessor :visitors

  def initialize(data)
    @json_data = data
    @values = {}
    @conversiona = 0
    @conversionb = 0
    @nonconversiona = 0
    @nonconversionb = 0
    @visitors = []
    calc_conversions
  end

  def cohorts_count
    @visitors.size
  end

  def calc_conversions
    @json_data.each do |element|
      calc_conversiona(element) if element['cohort'] == 'A'
      calc_conversionb(element) if element['cohort'] == 'B'
      @visitors << element['result']
    end
  end

  def calc_conversiona(element)
    raise InvalidCohortError unless element['result'] == 0 || element['result'] == 1
    @conversiona += 1 if element['result'] == 1
    @nonconversiona += 1 if element['result'] == 0
  end

  def calc_conversionb(element)
    raise InvalidCohortError unless element['result'] == 0 || element['result'] == 1
    @conversionb += 1 if element['result'] == 1
    @nonconversionb += 1 if element['result'] == 0
  end

  def conversion_rate(conversion, nonconversion)
    total__conversion = conversion + nonconversion
    ABAnalyzer.confidence_interval(conversion, total__conversion, CONV_FACTOR)
  end

  def create_converhash(conversion, nonconversion)
    convert_and_non_converta = {}
    convert_and_non_converta[:converted] = conversion
    convert_and_non_converta[:nonconverted] = nonconversion
    convert_and_non_converta
  end

  def confidence_score
    @values[:cohorta] = create_converhash(@conversiona, @nonconversiona)
    @values[:cohortb] = create_converhash(@conversionb, @nonconversionb)
    tester = ABAnalyzer::ABTest.new @values
    tester.chisquare_p
  end
end
