require 'spec_helper'

describe CohortImporter do
  describe "#initialize" do
    it "raises an error when nil filename is passed to it" do
      expect { CohortImporter.new(nil) }.to raise_error(InvalidFile)
    end
  end

  let(:cohort_importer) { CohortImporter.new('data_export_2015_06-3.json') }
  let(:parsed_group) { { "B" => { conversions: 380, non_conversions: 348 }, "A" => { conversions: 340, non_conversions: 320 } } }

  describe "#groups" do
    it "sets up the groups for the cohorts" do
      expect(cohort_importer.groups).to eq parsed_group
    end
  end
end
