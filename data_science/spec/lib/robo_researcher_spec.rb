require 'spec_helper'
require 'robo_researcher'

TWO_HASHES_FILE = "spec/spec_data/list_of_two_hashes.json"

describe RoboResearcher do
  context "when A is better than B" do
    context "when the difference is significantly better than random" do
      let(:researcher) { RoboResearcherFactory.create([250, 100, 250, 70]) }
      it "reports A is significantly better" do
        a_is_better = "Cohort A is better with 95% confidence.  The difference "
        a_is_better << "is significant with 99% confidence."
        expect(researcher.conclude).to eq(a_is_better)
      end
    end
    context "when the difference is insignificant" do
      let(:researcher) { RoboResearcherFactory.create([20, 10, 20, 9]) }
      it "reports there is no significant difference" do
        no_difference = "There is no significant difference between cohorts."
        expect(researcher.conclude).to eq(no_difference)
      end
    end
  end

  context "when B is better than A" do
    context "when the difference is significantly better than random" do
      let(:researcher) { RoboResearcherFactory.create([250, 50, 250, 100]) }
      it "reports B is significantly better" do
        b_is_better = "Cohort B is better with 95% confidence.  The difference "
        b_is_better << "is significant with 99.99% confidence."
        expect(researcher.conclude).to eq(b_is_better)
      end
    end
  end

  context "when asked for .details" do
    let(:researcher) { RoboResearcherFactory.create([25, 20, 25, 20]) }
    it "provides a description for each cohort" do
      expect(researcher.details.length).to be 2
    end
  end
end

module RoboResearcherFactory
  def self.create(fake_data)
    researcher = RoboResearcher.new
    researcher.cohorts = [
      Cohort.new(name: "A", size: fake_data[0], conversion_count: fake_data[1]),
      Cohort.new(name: "B", size: fake_data[2], conversion_count: fake_data[3]),
    ]
    researcher
  end
end
