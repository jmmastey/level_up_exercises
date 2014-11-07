require 'rspec'
require 'flight_stats/local_time'

describe 'local time conversions' do

  let(:no_timezone)     { DateTime.parse("2014-11-08T00:00:00.000+00:00") }
  let(:timezone)        { DateTime.parse("2014-11-08T00:00:00.000+01:00") }
  let(:different)       { DateTime.parse("2014-11-08T11:11:11.111+00:00") }
  let(:localtime_class) { Object.new.extend(LocalTime) }

  it 'The same time in different timezones should be equal' do
    expect(localtime_class.strip_timezone(timezone)).to eq(no_timezone)
  end

  it 'removing timezone should have no effect on datetime without timezone' do
    expect(localtime_class.strip_timezone(no_timezone)).to eq(no_timezone)
  end

  it 'different times in different timezones should be not equal' do
    expect(localtime_class.strip_timezone(different)).to_not eq(no_timezone)
  end
end
