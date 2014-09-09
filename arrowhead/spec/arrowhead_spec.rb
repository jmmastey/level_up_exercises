require 'spec_helper.rb'
require_relative '../lib/arrowhead.rb'

describe Arrowhead do
  before(:all) do
  end

  after(:all) do
  end

  context 'arrowhead' do
    describe "valid" do
      it "should return a valid arrowhead" do
        arrowhead = Arrowhead.classify(:far_west, :stemmed)
        expect(arrowhead).to match("Stemmed")
      end
    end

    describe "invalid" do
      it "should throw a proper error for a invalid region" do
        expect { Arrowhead.classify(:far_wessst, :stemmed) }.to raise_error
        (RuntimeError)
      end

      it "should throw a proper error for a invalid shape" do
        expect { Arrowhead.classify(:far_west, :stemmers) }.to raise_error
        (RuntimeError)
      end
    end
  end
end
