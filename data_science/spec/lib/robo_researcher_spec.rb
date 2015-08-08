require 'spec_helper'
require 'data_set'
require 'robo_researcher'

describe RoboResearcher do
  # happy path tests
  describe "#populate_cohorts" do
    let(:data) do
      DataSetFactory.create("A" => { conversions: 3, non_conversions: 1 },
                            "B" => { conversions: 0, non_conversions: 5 })
    end
    let(:researcher) { RoboResearcher.new }
    before { researcher.populate_cohorts(data) }
    it "populates both cohorts" do
      expect(researcher.cohorts.length).to eq(2)
    end

    it "populates views correctly for first cohort" do
      cohort_a = researcher.cohorts.detect { |cohort| cohort.name == "A" }
      expect(cohort_a.views).to eq(4)
    end

    it "populates views correctly for second cohort" do
      cohort_b = researcher.cohorts.detect { |cohort| cohort.name == "B" }
      expect(cohort_b.views).to eq(5)
    end

    it "populates conversions correctly for first cohort" do
      cohort_a = researcher.cohorts.detect { |cohort| cohort.name == "A" }
      expect(cohort_a.conversions).to eq(3)
    end

    it "populates conversions correctly for second cohort" do
      cohort_b = researcher.cohorts.detect { |cohort| cohort.name == "B" }
      expect(cohort_b.conversions).to eq(0)
    end
  end

  context "when A is significantly better than B" do
    let(:cohort_a) { Cohort.new(name: "A", views: 20, conversions: 18) }
    let(:cohort_b) { Cohort.new(name: "B", views: 20, conversions: 10) }
    let(:researcher) { RoboResearcher.new }
    describe "#significant?" do
      it "is true" do
        researcher.cohorts = [cohort_a, cohort_b]
        expect(researcher).to be_significant
      end
    end

    describe "#best_cohort" do
      it "returns cohort_a" do
        researcher.cohorts = [cohort_a, cohort_b]
        expect(researcher.best_cohort).to be(cohort_a)
      end
    end
  end

  context "when B is significantly better than A" do
    let(:cohort_a) { Cohort.new(name: "A", views: 20, conversions: 10) }
    let(:cohort_b) { Cohort.new(name: "B", views: 20, conversions: 18) }
    let(:researcher) { RoboResearcher.new }
    describe "#significant?" do
      it "is true" do
        researcher.cohorts = [cohort_a, cohort_b]
        expect(researcher).to be_significant
      end
    end

    describe "#best_cohort" do
      it "returns cohort_b" do
        researcher.cohorts = [cohort_a, cohort_b]
        expect(researcher.best_cohort).to be(cohort_b)
      end
    end
  end

  context "when A and B are equivalent" do
    let(:cohort_a) { Cohort.new(name: "A", views: 20, conversions: 18) }
    let(:cohort_b) { Cohort.new(name: "B", views: 20, conversions: 18) }
    let(:researcher) { RoboResearcher.new }
    describe "#best_cohort" do
      it "returns either cohort" do
        researcher.cohorts = [cohort_a, cohort_b]
        expect([cohort_a, cohort_b]).to include(researcher.best_cohort)
      end
    end
  end

  # sad path test
  context "when A and B are equivalent" do
    let(:cohort_a) { Cohort.new(name: "A", views: 200, conversions: 100) }
    let(:cohort_b) { Cohort.new(name: "B", views: 200, conversions: 100) }
    let(:researcher) { RoboResearcher.new }
    it "is false" do
      researcher.cohorts = [cohort_a, cohort_b]
      expect(researcher).not_to be_significant
    end
  end

  # bad path tests
  context "when there is no cohort" do
    let(:researcher) { RoboResearcher.new }
    describe "#significant?" do
      it "raises an error" do
        expect { researcher.significant? }.to(
          raise_error(BadData, /Need 2 .* found 0./))
      end
    end

    describe "#significance_of_difference" do
      it "raises an error" do
        expect { researcher.significance_of_difference }.to(
          raise_error(BadData, /Need 2 .* found 0./))
      end
    end
  end

  context "when there is only one cohort" do
    let(:data) do
      DataSetFactory.create("A" => { conversions: 3, non_conversions: 1 })
    end
    let(:researcher) { RoboResearcher.new }
    before { researcher.populate_cohorts(data) }
    describe "#significant?" do
      it "raises an error" do
        expect { researcher.significant? }.to(
          raise_error(BadData, /Need 2 .* found 1./))
      end
    end

    describe "#significance_of_difference" do
      it "raises an error" do
        expect { researcher.significance_of_difference }.to(
          raise_error(BadData, /Need 2 .* found 1./))
      end
    end
  end

  context "when there are three cohorts" do
    let(:data) do
      DataSetFactory.create("A" => { conversions: 3, non_conversions: 1 },
                            "B" => { conversions: 0, non_conversions: 5 },
                            "C" => { conversions: 5, non_conversions: 0 })
    end
    let(:researcher) { RoboResearcher.new }
    before { researcher.populate_cohorts(data) }
    describe "#significant?" do
      it "raises an error" do
        expect { researcher.significant? }.to(
          raise_error(BadData, /Need 2 .* found 3./))
      end
    end

    describe "#significance_of_difference" do
      it "raises an error" do
        expect { researcher.significance_of_difference }.to(
          raise_error(BadData, /Need 2 .* found 3./))
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

module DataSetFactory
  def self.create(cohort_infos)
    data = []
    cohort_infos.each do |name, counts|
      counts[:conversions].times { data << { cohort: name, result: 1 } }
      counts[:non_conversions].times { data << { cohort: name, result: 0 } }
    end
    DataSet.new(data_points: data)
  end
end
