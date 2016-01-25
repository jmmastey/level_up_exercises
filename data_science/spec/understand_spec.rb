
require 'spec_helper'
require_relative '../understand.rb'

RSpec.describe "test" do
  before :all do
    file = File.read(FILETOIMPORT)
    @data_hash = JSON.parse(file)
    @hash_keys = @data_hash[0].keys
    @random_sample1 = @data_hash[rand(100)]
    @random_sample2 = @data_hash[rand(100)]
    @random_sample3 = @data_hash[rand(100)]
    DataScience.raw_results
    DataScience.significant_difference?
  end

  it "should have a class import" do
    expect(DataScience).to be_kind_of(Class)
  end

  it "should have correct filename" do
    expect(FILETOIMPORT).to eq "data_export_2014_06_20_15_59_02.json"
  end

  it "should have the correct sample size" do
    expect(@data_hash.length).to eq 2892
  end

  it "should have a data structure that follows" do
    expect(@hash_keys).to include("date")
    expect(@hash_keys).to include("cohort")
    expect(@hash_keys).to include("result")
  end

  it "should have cohorts that are only A or B" do
    expect(@random_sample1["cohort"]).to match(/(A|B)/)
    expect(@random_sample2["cohort"]).to match(/(A|B)/)
    expect(@random_sample3["cohort"]).to match(/(A|B)/)
  end

  it "should have results that are numbers" do
    expect(@random_sample1["result"]).to be_a(Integer)
    expect(@random_sample2["result"]).to be_a(Integer)
    expect(@random_sample3["result"]).to be_a(Integer)
  end

  it "produces a summary of raw results" do
    expect(DataScience.raw_results).to be_kind_of(Object)
    expect(DataScience.instance_variable_get(:@a_count)).not_to eql(nil)
    expect(DataScience.instance_variable_get(:@a_nonconverts)).not_to eql(nil)
  end

  it "significant_difference?" do
    expect(DataScience.significant_difference?).to be_kind_of(Object)
    expect(DataScience.instance_variable_get(:@significant_difference)).to be_a(Boolean)
  end

  it "confidence level range" do
    expect(DataScience.confidence_level).to be_kind_of(Object)
    expect(DataScience.instance_variable_get(:@a_conf_range)).not_to eql(nil)
    expect(DataScience.instance_variable_get(:@b_conf_range)).not_to eql(nil)
  end

  it "chi_leader" do
    expect(DataScience.chi_leader).to be_kind_of(Object)
  end
end
