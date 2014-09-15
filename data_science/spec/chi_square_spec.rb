require "spec_helper"
require_relative "../chi_square"

describe ChiSquare do
  let(:chi_square) { ChiSquare.new(4,3,2,1) }

  describe "#initialize" do
    #its(:group_a_visitors) { should == 4 }
    #its(:group_a_conversions) { should == 3 }
    #its(:group_b_visitors) { should == 2 }
    #its(:group_b_conversions) { should == 1 }

    it "must have values for visitors/conversions for each group" do
    end

    it "raises an error it not all visitors/conversions are set" do
    end

  end

  describe "#value" do
    it "correctly calculates chi square for given inputs" do
    end
  end

  describe "#significance" do
    it "calculates significance at 95% level" do
    end
  end
end

