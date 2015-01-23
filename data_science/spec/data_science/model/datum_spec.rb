require './spec/spec_helper.rb'

describe Model::Datum do
  describe "#initialize" do
    let(:data) { Model::Datum.new(1,20150101,1) }
    it "initiualizes a new object" do
      expect(data).to be_a(Model::Datum)
    end
  end

  describe "#attr_accessor" do
    let(:data) { Model::Datum.new(1,20150101,1) }
    [:cohort, :date, :result].each do |accessor|
      it { expect(data).to have_attr_accessor(accessor) }
    end
  end
end
