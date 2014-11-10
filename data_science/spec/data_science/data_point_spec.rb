require 'data_science/data_point'

describe DataPoint do
  before do
    @data_point = Sample.new({"date"=>"2014-03-20", "cohort"=>"B", "result"=>0})
  end


  it 'has a date' do
    expect(@data_point.date).to eq("2014-03-20")
  end
end
