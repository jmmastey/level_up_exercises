require_relative '../robot_name'

describe Robot do
  context "when creating a new robot without passing a name generator" do
    describe "#new" do

      robot = Robot.new

      it "assigns a value to name" do
        expect(robot.name).to match(/^[A-Z]{2}[0-9]{3}$/)
      end
    end
  end
end
