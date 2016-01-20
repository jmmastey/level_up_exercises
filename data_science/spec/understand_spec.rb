
require 'spec_helper'
require_relative '../understand.rb'

RSpec.describe "test" do
  it "should have a class import" do
    expect(DataScience).to be_kind_of(Class)
  end

  it "should have correct filename" do
    expect(FILETOIMPORT).to eq "data_export_2014_06_20_15_59_02.json"
  end

  it "should have the correct sample size" do
    file = File.read(FILETOIMPORT)
    @data_hash = JSON.parse(file)
    expect(@data_hash.length).to eq 2892
  end
end
