require_relative '../loader.rb'

describe Loader do
  let(:loader) { Loader.new(experiment_file) }

  describe '#parse' do
    let(:parse_data) { loader.parse }

    context "if there is no file" do
      let(:experiment_file) { "" }
      it "raises an error" do
        expect{ parse_data }.to raise_error
      end
    end

    context "if JSON file is correct format" do
      let(:experiment_file) { "./test.json" }
      it "returns a collection of data" do
        expect(parse_data).to be_an(Enumerable)
      end
      it "collection contains hashes" do
        expect(parse_data).to all(be_a(Hash))
      end
    end
  end
end
