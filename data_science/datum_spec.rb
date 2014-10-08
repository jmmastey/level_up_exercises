require_relative 'datum'

describe Datum do
  datum = Datum.new("date" => "2014-03-20", "cohort" => "B", "result" => 1)

  it "should contain expected attributes" do
    expect(datum).to have_attributes(date: '2014-03-20')
    expect(datum).to have_attributes(cohort: 'B')
    expect(datum).to have_attributes(result: 1)
  end
end
