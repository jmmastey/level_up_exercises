require 'spec_helper'
require 'data_science'

describe DataScience do
  # happy path tests
  it "outputs to std_out" do
    expect { subject.report }.to output.to_stdout
  end

  context "when B is significantly better than A" do
    let(:researcher) { RoboResearcherFactory.create([250, 50, 250, 100]) }
    it "reports B is significantly better" do
      data_science = DataScience.new(researcher: researcher)
      conclusion = data_science.conclude
      expect(conclusion).to include("Cohort B is better")
      expect(conclusion).to include("95% confidence")
      expect(conclusion).to include("is significant")
      expect(conclusion).to include("99% confidence")
    end
  end

  context "when A is better than B" do
    context "when the difference is significantly better than random" do
      let(:researcher) { RoboResearcherFactory.create([250, 100, 250, 70]) }
      it "reports A is significantly better" do
        data_science = DataScience.new(researcher: researcher)
        conclusion = data_science.conclude
        expect(conclusion).to include("Cohort A is better")
        expect(conclusion).to include("95% confidence")
        expect(conclusion).to include("is significant")
        expect(conclusion).to include("99% confidence")
      end
    end

    # sad path test
    context "when the difference is insignificant" do
      let(:researcher) { RoboResearcherFactory.create([20, 10, 20, 9]) }
      it "reports there is no significant difference" do
        data_science = DataScience.new(researcher: researcher)
        expect(data_science.conclude).to include("no significant difference")
      end
    end
  end
end

module RoboResearcherFactory
  def self.create(fake_data)
    RoboResearcher.new.tap do |researcher|
      researcher.cohorts = [
        Cohort.new(name: "A", views: fake_data[0], conversions: fake_data[1]),
        Cohort.new(name: "B", views: fake_data[2], conversions: fake_data[3]),
      ]
    end
  end
end
