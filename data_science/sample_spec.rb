require_relative 'dataloader.rb'
require_relative 'data.rb'
require_relative 'sample.rb'

describe Sample do

  it "Calculate_values function is working, using group_a's data" do
    @data_in = DataLoader.read_in_json("smalldata.json")
    DataLoader.build_data(@data_in)
    group_a, _group_b = DataLoader.seperate_groups

    values = {}
    @confidence_a = Sample.calculate_values(group_a, :agroup, values)
    expect(@confidence_a[:low]).to eql(-19.3)
    expect(@confidence_a[:high]).to eql(119.3)
    expect(values[:agroup][:num_convs]).to eql(1)
    expect(values[:agroup][:vistors]).to eql(2)
  end

  it "Verify the percent turnover is working" do
    @data_in = DataLoader.read_in_json("smalldata.json")
    DataLoader.build_data(@data_in)
    group_a, _group_b = DataLoader.seperate_groups

    values = {}
    @confidence_a = Sample.calculate_values(group_a, :agroup, values)
    num_convs = values[:agroup][:num_convs]
    vistors = values[:agroup][:vistors]
    percent = Sample.calc_percent(num_convs, vistors)
    expect(percent).to eql(50.0)
  end
end
