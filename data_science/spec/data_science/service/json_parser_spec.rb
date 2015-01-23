require './spec/spec_helper.rb'

describe Service::JsonParser do
  describe "#self.parse" do
    let(:json_parser) { Service::JsonParser.parse(file) }
    context "when file_exists? = true" do
      let(:file) { './source_data.json' }
      it "parses and is not empty" do
        expect(json_parser).to_not be_empty
      end
      it "returns an array" do
        expect(json_parser).to be_a(Array)
      end
    end
    context "when file_exists? = false" do
      let(:file) { './banana_explosion.json' }
      it "raises an error" do
        expect { json_parse }.to raise_error
      end
    end
  end

  describe "#self.file_exists?" do
    let(:json_parser) { Service::JsonParser.file_exists?(file) }
    context "when it finds the file" do
      let(:file) { './source_data.json' }
      it "returns true" do
        expect(json_parser).to be_truthy
      end
    end
    context "whhen it can not find the file" do
      let(:file) { './banana_explosion.json' }
      it "returns false" do
        expect(json_parser).to be_falsey
      end
    end
  end
  describe "#self.file_empty?" do
    let(:json_parser) { Service::JsonParser.file_empty?(file) }
    context "when file is not empty" do
      let(:file) { './source_data.json' }
      it "returns false" do
        expect(json_parser).to be_falsey
      end
    end
    context "when file is empty" do
      let(:file) { './spec/fixtures/no_data.json' }
      it "returns true" do
        expect(json_parser).to be_truthy
      end
    end
  end
end
