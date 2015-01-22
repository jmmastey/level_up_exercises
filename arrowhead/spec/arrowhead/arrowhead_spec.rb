require './spec/spec_helper.rb'

describe Arrowhead do
  describe "#self.classify" do
    context "when it successfully classifies" do
      it "contains /Oxbow/ on the output" do
        output = capture_stdout { Arrowhead.classify(:northern_plains, :bifurcated) }
        expect(output).to include('Oxbow')
      end
    end
    context "when it does not successfully classify" do
      context "when it can not find the region" do
        it "raises an error" do
          expect{ Arrowhead.classify(:land_of_svajone, :stemmed) }.to raise_error
        end
      end
      context "when it can not find the shape" do
        it "raises an error" do
          expect{ Arrowhead.classify(:northern_plains, :svajone) }.to raise_error
        end
      end
    end
  end

  describe "#self.has_region?" do
    context "when it has region" do
      it "returns true" do
        expect(Arrowhead.has_region?(:northern_plains)).to be_truthy
      end
    end
    context "when it has no region" do
      it "raises an error" do
        expect{ Arrowhead.has_region?(:banana) }.to raise_error
      end
    end
  end

  describe "#self.has_shape?" do
    context "when it has shape" do
      it "returns true" do
        expect(Arrowhead.has_shape?(:northern_plains, :bifurcated)).to be_truthy
      end
    end
    context "when it has no shape" do
      it "raises an error" do
        expect{ Arrowhead.has_shape?(:northern_plains, :banana) }.to raise_error
      end
    end
  end

  def capture_stdout(&block)
    unless block_given?
      raise "You need to pass a block sir!"
    end
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

end


describe ErrorHandler do

  describe "#self.no_shape" do
    it "raises an error" do
      expect{ ErrorHandler.no_shape }.to raise_error
    end
  end

  describe "#self.no_region" do
    it "raises an error" do
      expect{ ErrorHandler.no_region }.to raise_error
    end
  end

end
