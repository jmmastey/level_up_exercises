require './spec/spec_helper.rb'

describe CalculateAngles do
  let(:side_a) { 5 }
  let(:side_b) { 5 }
  let(:side_c) { 5 }
  let(:calculate_angles) { CalculateAngles.new(side_a, side_b, side_c) }

  describe "#initialize" do
    it "initializes a new object" do
      expect(calculate_angles).to be_a(CalculateAngles)
    end
  end

  describe "#radians_to_degrees" do
    it "converts radians into degrees" do
      # NOTE:
      # The testing done here is using a proven data set calculated outside of this
      # class or method.
      expected_output = 60
      radian = Math.acos((5**2 + 5**2 - 5**2) / (2.0 * 5 * 5))
      expect(calculate_angles.radians_to_degrees(radian)).to eq(expected_output)
    end
  end

  describe "#calculate_angles" do
    context "when it calculates angles" do
      let(:calculate) { calculate_angles.calculate }
      it "returns an array" do
        expect(calculate).to be_a(Array)
      end
      it "returns an array with three items" do
        expect(calculate.count).to eq(3)
      end
      it "returns a non empty array" do
        expect(calculate).to_not be_empty
      end
      it "returns accurate calculations" do
        # NOTE:
        # The testing done here is using proven data set calcilated outsode of this
        # class or method
        expected_output = [60, 60, 60]
        expect(calculate).to eq(expected_output)
      end
    end
  end

 describe "#calculate_radians" do
    it "calculates a radian using 3 sides of a triangle" do
      # NOTE :
      # The testing done here is using a proven data set calculated outside of this
      # class or method
      output = 1.0471975511965976
      expect(calculate_angles.calculate_radians(5,5,5)).to eq(output)
    end
  end

end
