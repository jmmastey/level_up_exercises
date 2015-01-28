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

  describe "#self.process_json" do
    let(:datum) { Model::Datum.process_json(file) }
    context "when the json data is not empty" do
      let(:file) { './source_data.json' }
      it "processes the json file" do
        expect(datum).to be_truthy
      end
      it "returns an array" do
        expect(datum).to be_a(Array)
      end
      it "returns a non empty array" do
        expect(datum).to_not be_empty
      end
    end
    context "when the json data is empty" do
      let(:file) { './fixtures/no_data.json' }
      it "raises an error" do
        expect { datum }.to raise_error
      end
    end
  end
end
