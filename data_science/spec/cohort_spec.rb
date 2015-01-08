require 'spec_helper'

describe Cohort do

  let(:test) { Cohort.new( {a: 1} ) }
	context "Upon creation" do
	 it "should create a Cohort instance" do
      expect(test).to be_an_instance_of(Cohort)
    end
  end
end