require './spec/spec_helper.rb'

describe Triangle do
  let(:triangle_parameters) { [ rand(5..10), rand(5..10), rand(5..10) ] }
  let(:equilateral) { [5, 5, 5] }
  let(:isosceles) { [3, 3, 4] }
  subject(:triangle) { Triangle.new(*triangle_parameters) }

  describe "#initialize" do
    it "initializes a new Triangle Facts" do
      expect(triangle).to be_a(Triangle)
    end
  end

  describe "#equilateral" do
    context "when it is equilateral" do
      let(:triangle_parameters) { equilateral }
      it "returns true" do
        expect(triangle.equilateral).to be_truthy
      end
    end
    context "when it is not equilateral" do
      let(:triangle_parameters) { [30, 50, 33] }
      it "returns false" do
        expect(triangle.equilateral).to be_falsey
      end
    end
  end

  describe "#isosceles" do
    context "when it is an isosceles" do
      let(:triangle_parameters) { isosceles }
      it "returns true" do
        expect(triangle.isosceles).to be_truthy
      end
    end
    context "when it s not an isosceles" do
      let(:triangle_parameters) { [31, 32,33] }
      it "returns false" do
        expect(triangle.isosceles).to be_falsey
      end
    end
  end

  describe "#scalene" do
    context "when equilateral is true" do
      let(:triangle_parameters) { equilateral }
      it "returns false" do
        expect(triangle.scalene).to be_falsey
      end
    end
    context "when equilateral is false" do
      let(:triangle_parameters) { [30, 50, 33] }
      it "returns true" do
        expect(triangle.scalene).to be_truthy
      end
    end
    context "when isosceles is true" do
      let(:triangle_parameters) { isosceles }
      it "returns false" do
        expect(triangle.scalene).to be_falsey
      end
    end
    context "when isosceles is false" do
      let(:triangle_parameters) { [31,32,33] }
      it "returns true" do
        expect(triangle.scalene).to be_truthy
      end
    end
  end

  describe "#recite_facts" do
    context "when checking if it's equilateral" do
      context "when it's equilateral" do
      let(:triangle_parameters) { equilateral }
        it "contains /This triangle is equilateral/ on the output" do
          output = capture_stdout { triangle.recite_facts }
          expect(output).to include("This triangle is equilateral")
        end
      end
      context "when it's not equilateral" do
      let(:triangle_parameters) { [30, 50, 33] }
        it "does not contain /This triangle is equilateral/ on the output" do
          output = capture_stdout { triangle.recite_facts }
          expect(output).to_not include("This triangle is equilateral")
        end
      end
    end
    context "when checking if it's an isosceles" do
      context "when it's an isosceles" do
      let(:triangle_parameters) { isosceles }
        it "contains /This triangle is isosceles! Also, that word is hard to type." do
          output = capture_stdout { triangle.recite_facts }
          expect(output).to include("This triangle is isosceles! Also, that word is hard to type.")
        end
      end
      context "when it's not an isosceles" do
      let(:triangle_parameters) { [31,32,33] }
        it "does not contain /This triangle is isosceles! Also, that word is hard to type." do
          output = capture_stdout { triangle.recite_facts }
          expect(output).to_not include("This triangle is isosceles! Also, that word is hard to type.")
        end
      end
    end
    context "when checking if it's scalene" do
      context "when it's scalene" do
      let(:triangle_parameters) { [ [30, 50, 33], [31,32,33] ].sample }
       it "contains /This triangle is scalenben and mathematically boring./" do
         output = capture_stdout { triangle.recite_facts }
         expect(output).to include("This triangle is scalene and mathematically boring.")
       end
      end
      context "when it's not scalene" do
      let(:triangle_parameters) { [equilateral, isosceles].sample }
       it "does not contain /This triangle is scalenben and mathematically boring./" do
         output = capture_stdout { triangle.recite_facts }
         expect(output).to_not include("This triangle is scalene and mathematically boring.")
       end
      end
    end
    context "when checking if it's a right angle" do
      context "when it's a right angle" do
      let(:triangle_parameters) { [5,12,13] }
        it "contains /This triangle is also a right triangle!" do
          output = capture_stdout { triangle.recite_facts }
          expect(output).to include("This triangle is also a right triangle!")
        end
      end
      context "when it's not a right angle" do
      let(:triangle_parameters) { [22,32,33] }
        it "does not contain /This triangle is also a right triangle!" do
          output = capture_stdout { triangle.recite_facts }
          expect(output).to_not include("This triangle is also a right triangle!")
        end
      end
    end
    context "when it displays the calculated angles" do
      it "displays the angles of the triangle" do
        angles = triangle.calculate_angles(triangle_parameters[0], triangle_parameters[1], triangle_parameters[2])
        output = capture_stdout { triangle.recite_facts }
        expect(output).to include(angles.join(','))
      end
      it "contains /The angles of this triangle are" do
        output = capture_stdout { triangle.recite_facts }
        expect(output).to include("The angles of this triangle are")
      end
    end
  end

  describe "#calculate_angles" do
    context "when a calculation is made" do
      subject(:triangle_calculate) { triangle.calculate_angles(60,60,60) }
      it "returns an array" do
        expect(triangle_calculate).to be_a(Array)
      end
      it "returns a non empty array" do
        expect(triangle_calculate).to_not be_empty
      end
      it "returns three values in the array" do
        expect(triangle_calculate.count).to eq(3)
      end
    end
  end

  def capture_stdout(&block)
    unless block_given?
      raise "You need to pass a block sir"
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
