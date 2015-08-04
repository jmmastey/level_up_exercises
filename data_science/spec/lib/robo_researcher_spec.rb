require 'spec_helper'
require 'robo_researcher'

TWO_HASHES_FILE = "spec/spec_data/list_of_two_hashes.json"

describe RoboResearcher do
  context "when A is better than B" do
    context "when the difference is significantly better than random" do
      let(:researcher) { RoboResearcherFactory.create([250, 100, 250, 70]) }
      it "reports A is significantly better" do
        conclusion = researcher.conclude
        expect(conclusion).to include("Cohort A is better")
        expect(conclusion).to include("95% confidence")
        expect(conclusion).to include("is significant")
        expect(conclusion).to include("99% confidence")
      end
    end

    context "when the difference is insignificant" do
      let(:researcher) { RoboResearcherFactory.create([20, 10, 20, 9]) }
      it "reports there is no significant difference" do
        expect(researcher.conclude).to include("no significant difference")
      end
    end
  end

  context "when B is significantly better than A" do
    let(:researcher) { RoboResearcherFactory.create([250, 50, 250, 100]) }
    it "reports B is significantly better" do
      conclusion = researcher.conclude
      expect(conclusion).to include("Cohort B is better")
      expect(conclusion).to include("95% confidence")
      expect(conclusion).to include("is significant")
      expect(conclusion).to include("99% confidence")
    end
  end

  describe "#details" do
    let(:researcher) { RoboResearcherFactory.create([25, 20, 25, 20]) }
    it "provides a description for each cohort" do
      expect(researcher.details.length).to be 2
    end
  end
end

module RoboResearcherFactory
  def self.create(fake_data)
    RoboResearcher.new.tap do |researcher|
      researcher.cohorts = [Cohort.new("A", fake_data[0], fake_data[1]),
                            Cohort.new("B", fake_data[2], fake_data[3])]
    end
  end
end
