require 'spec_helper'

describe Cohort do

  let(:test) { Cohort.new("A", 47, 1349) }
  context "Upon creation" do
    it "should create a Cohort instance" do
      expect(test).to be_an_instance_of(Cohort)
    end

    it "should contain conversion data" do
      expect(test.pass).to be >= 0
      expect(test.fail).to be >= 0 
    end
  end
end
