require_relative '../robot_name'

describe Robot do
  describe "#new" do
    context "when creating a new robot without passing parameters" do
      before(:each) do
        @robot = Robot.new
      end

      it "assigns a value to name" do
        expect(@robot.name).to match(/^[A-Z]{2}[0-9]{3}$/)
      end
    end

    context "when creating a new robot and passing a name parameter" do
      it "assigns passed value to name" do
        robot = Robot.new(name: "AA000")
        expect(robot.name).to eq("AA000")
      end

      it "raises an error when names collide" do
        expect do
          Robot.new(name: "AA000")
          Robot.new(name: "AA000")
        end.to raise_error(
          NameCollisionError,
          'Robot name "AA000" already exists!',
        )
      end
    end

    context "when creating a new robot and passing in a name generator" do
      it "generates and assigns a name using name_generator" do
        robot = Robot.new(name_generator: -> { "RR111" })

        expect(robot.name).to eq("RR111")
      end
    end

    context "assigning a non-valid name" do
      it "raises an error when name_generator name creates an invalid name" do
        expect { Robot.new(name_generator: -> { "foobar" }) }.to raise_error(
          NameFormatError,
          'Robot name "foobar" is wrong format!',
        )
      end

      it "raises an error when passed name is invalid" do
        expect { Robot.new(name_generator: -> { "barbaz" }) }.to raise_error(
          NameFormatError,
          'Robot name "barbaz" is wrong format!',
        )
      end
    end
  end
end
