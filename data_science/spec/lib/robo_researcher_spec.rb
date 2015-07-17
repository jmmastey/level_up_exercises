require 'spec_helper'
require 'robo_researcher'

TWO_HASHES_FILE = "spec/spec_data/list_of_two_hashes.json"

describe RoboResearcher do
  context "when the researcher has no data" do
    let(:researcher) { RoboResearcher.new }
    it "can return the total sample size" do
      expect(researcher.sample_size).to be 0
    end
  end
  context "when the researcher has data" do
    let(:researcher) { RoboResearcher.new(data_file: TWO_HASHES_FILE) }
    it "can return the total sample size" do
      expect(researcher.sample_size).to be 2
    end
  end

  context "when there are only 2 cohort B conversions" do
    let(:researcher) { RoboResearcher.new(data_file: TWO_HASHES_FILE) }
    it "will report cohort A has 0 conversions" do
      expect(researcher.cohort("A").conversion_count).to be(0)
    end
    it "will report cohort B has 2 conversions" do
      expect(researcher.cohort("B").conversion_count).to be(2)
    end
  end

  context "when A is better than B" do
    context "when A is significantly better than random" do
      let(:researcher) { RoboResearcherFactory.create([25, 20, 13, 5]) }
      it "reports A is significantly better" do
        a_is_better = "Cohort A is significantly better than random."
        expect(researcher.conclude).to eq(a_is_better)
      end
    end
    context "when A is significantly worse than random" do
      let(:researcher) { RoboResearcherFactory.create([25, 5, 30, 5]) }
      it "reports A is NOT significantly better" do
        a_is_not_better = "Cohort A is NOT significantly better than random."
        expect(researcher.conclude).to eq(a_is_not_better)
      end
    end
    context "when A is similar to random" do
      let(:researcher) { RoboResearcherFactory.create([20, 10, 20, 9]) }
      it "reports A is NOT significantly better" do
        a_is_not_better = "Cohort A is NOT significantly better than random."
        expect(researcher.conclude).to eq(a_is_not_better)
      end
    end
  end

  context "when B is better than A" do
    context "when B is significantly better than random" do
      let(:researcher) { RoboResearcherFactory.create([13, 5, 25, 20]) }
      it "reports B is significantly better" do
        a_is_better = "Cohort B is significantly better than random."
        expect(researcher.conclude).to eq(a_is_better)
      end
    end
  end

  context "when A matches B" do
    context "when they are significantly better than random" do
      let(:researcher) { RoboResearcherFactory.create([25, 20, 25, 20]) }
      it "does something" do
        both_better = "Cohort A and B are significantly better than random."
        expect(researcher.conclude).to eq(both_better)
      end
    end
  end

  context "when asked for .details" do
    let(:researcher) { RoboResearcherFactory.create([25, 20, 25, 20]) }
    it "provides a hash with an entry for each cohort" do
      expect(researcher.details).to have_key("A")
      expect(researcher.details).to have_key("B")
    end

    it "includes conversion_rate_interval for each cohort" do
      expect(researcher.details["A"].conversion_rate_interval).not_to be_nil
      expect(researcher.details["B"].conversion_rate_interval).not_to be_nil
    end

    it "includes confidence_of_significance for each cohort" do
      expect(researcher.details["A"].confidence_of_significance).not_to be_nil
      expect(researcher.details["B"].confidence_of_significance).not_to be_nil
    end
  end
end

module RoboResearcherFactory
  def self.create(fake_data)
    researcher = RoboResearcher.new
    researcher.cohorts["A"] =
      Cohort.new(name: "A", size: fake_data[0], conversion_count: fake_data[1])
    researcher.cohorts["B"] =
      Cohort.new(name: "B", size: fake_data[2], conversion_count: fake_data[3])
    researcher
  end
end
