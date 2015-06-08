require 'conversion_calculator'
require 'import_data'
require 'abanalyzer'

RSpec.describe ConversionCalculator do
  before(:each) do
    @confidence = 0.95
    @a_conversion = 340
    @a_sample = 660
    @b_conversion = 380
    @b_sample = 728
    @data = ImportData.new('data_export_2015_06-3.json').data
    @calc = ConversionCalculator.new(@data)
  end

  it "#sample_size" do
    expect(@calc.sample_size('A')).to eq @a_sample
    expect(@calc.sample_size('B')).to eq @b_sample
  end

  it "#conversion_num" do
    expect(@calc.conversion_num('A')).to eq @a_conversion
    expect(@calc.conversion_num('B')).to eq @b_conversion
  end

  it "#non_conversion_num" do
    expect(@calc.non_conversion_num('A')).to eq @a_sample - @a_conversion
    expect(@calc.non_conversion_num('B')).to eq @b_sample - @b_conversion
  end

  it "#conversion_rate" do
    expect(@calc.conversion_rate('A')).to eq ABAnalyzer.confidence_interval(@a_conversion, @a_sample, @confidence)
    expect(@calc.conversion_rate('B')).to eq ABAnalyzer.confidence_interval(@b_conversion, @b_sample, @confidence)
  end

  it "#chi_square" do
    expect(@calc.chi_square).to eq 0.0646179059352707
  end

  it "#different" do
    expect(@calc.different?).to eq false
  end
end
