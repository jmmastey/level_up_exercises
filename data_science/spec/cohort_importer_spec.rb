require 'spec_helper'

describe CohortImporter do
  describe "#initialize" do 
    it "raises an error when nil filename is passed to it" do
      expect { CohortImporter.new(nil) }.to raise_error(InvalidFile)
    end
  end

  let(:cohort_importer) { CohortImporter.new('data_export_2015_06-3.json') }
  let(:parsed_group) { {"B"=>{:conversions=>380, :non_conversions=>348}, "A"=>{:conversions=>340, :non_conversions=>320}} }
  let(:group_a) { {"A"=>{:conversions=>340, :non_conversions=>320}} }
  let(:group_b) { {"B"=>{:conversions=>380, :non_conversions=>348}} }
  let(:cohort_a) { Cohort.new(group_a) }
  let(:cohort_b) { Cohort.new(group_b) }

  describe "#groups" do
    it "sets up the groups for the cohorts" do
      expect(cohort_importer.groups).to eq parsed_group
    end
  end
end
