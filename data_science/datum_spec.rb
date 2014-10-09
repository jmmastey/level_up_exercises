require_relative 'datum'

describe Datum do
  subject(:datum) { Datum.new(date: "2014-03-20", cohort: "B", result: 1) }

  context "contains expected attributes" do
    it { expect(datum).to have_attributes(date: "2014-03-20") }
    it { expect(datum).to have_attributes(cohort: "B") }
    it { expect(datum).to have_attributes(result: 1) }
  end
end
