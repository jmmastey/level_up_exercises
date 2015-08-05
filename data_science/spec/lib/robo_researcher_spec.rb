require 'spec_helper'
require 'data_set'
require 'robo_researcher'

describe RoboResearcher do
  describe "#populate_cohort" do
    let(:data) do
      DataSetFactory.create("A" => { conversions: 3, non_conversions: 1 },
                            "B" => { conversions: 0, non_conversions: 5 })
    end
    let(:researcher) { RoboResearcher.new }
    it "populates both cohorts" do
      researcher.populate_cohorts(data)
      expect(researcher.cohorts.length).to eq(2)
    end

    it "populates views and conversions correctly for first cohort" do
      researcher.populate_cohorts(data)
      cohort_a = researcher.cohort("A")
      expect(cohort_a.views).to eq(4)
      expect(cohort_a.conversions).to eq(3)
    end

    it "populates views and conversions correctly for second cohort" do
      researcher.populate_cohorts(data)
      cohort_b = researcher.cohort("B")
      expect(cohort_b.views).to eq(5)
      expect(cohort_b.conversions).to eq(0)
    end
  end

  describe "#best_cohort" do
    context "when A is better than B" do
      let(:cohort_a) { Cohort.new(name: "A", views: 20, conversions: 18) }
      let(:cohort_b) { Cohort.new(name: "B", views: 20, conversions: 10) }
      let(:researcher) { RoboResearcher.new }
      it "returns cohort_a" do
        researcher.cohorts = [cohort_a, cohort_b]
        expect(researcher.best_cohort).to be(cohort_a)
      end
    end

    context "when B is better than A" do
      let(:cohort_a) { Cohort.new(name: "A", views: 20, conversions: 10) }
      let(:cohort_b) { Cohort.new(name: "B", views: 20, conversions: 18) }
      let(:researcher) { RoboResearcher.new }
      it "returns cohort_b" do
        researcher.cohorts = [cohort_a, cohort_b]
        expect(researcher.best_cohort).to be(cohort_b)
      end
    end

    context "when A and B are equivalent" do
      let(:cohort_a) { Cohort.new(name: "A", views: 20, conversions: 18) }
      let(:cohort_b) { Cohort.new(name: "B", views: 20, conversions: 18) }
      let(:researcher) { RoboResearcher.new }
      it "returns either cohort" do
        researcher.cohorts = [cohort_a, cohort_b]
        expect([cohort_a, cohort_b]).to include(researcher.best_cohort)
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
