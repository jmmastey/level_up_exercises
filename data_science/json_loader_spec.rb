require_relative "json_loader"

describe JSONLoader do
  subject(:file_loader) { JSONLoader.new("source_data.json") }

  context "verify legit data source" do
    it { expect(file_loader.file_name).to end_with(".json") }
  end

  context "load data from data source" do
    it { expect(file_loader.fetch_data).not_to be_empty }
  end
end
