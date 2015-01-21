require_relative '../data_loader'
require_relative '../traffic'
require_relative '../sample'

describe Sample do

  before(:each) do
    a = DataLoader.new("../smalldata.json")
    a.read_in_json
    a.build_data
    group_a, _groupb = a.seperate_groups
    @values = {}
    sample_a = Sample.new(group_a, @values)
    @confidence_a = sample_a.calc_values
  end

  it "Calculate_values function is working, using group_a's data" do
    expect(@confidence_a[:low]).to eql(-19.3)
    expect(@confidence_a[:high]).to eql(119.3)
    expect(@values[:A][:num_convs]).to eql(1)
    expect(@values[:A][:vistors]).to eql(2)
  end

  it "Verify the percent turnover is working" do
    num_convs = @values[:A][:num_convs]
    vistors = @values[:A][:vistors]
    percent = Sample.calc_percent(num_convs, vistors)
    expect(percent).to eql(50.0)
  end

end
