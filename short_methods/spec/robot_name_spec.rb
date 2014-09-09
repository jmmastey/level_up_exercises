require 'spec_helper.rb'
require_relative '../lib/robot_name.rb'

describe Robot do

  context "Single Name" do
    it "should generate a proper random name" do
      robot = Robot.new
      expect(robot.name).to_not be_nil
    end

    it "should use a specified name instead of random" do
      generator = -> { 'AA111' }
      robot = Robot.new(name_generator: generator)
      expect(robot.name).to eq("AA111")
    end
  end

  context "Multiple Names" do
    it "should not contain a duplicate name in the registry" do
      robot = Robot.new
      expect {
        5000.times.map { robot.generate_name }
      }.not_to raise_error
    end

    it "should contain exactly 5001 names in the registry" do
      robot = Robot.new
      5000.times.map { robot.generate_name }
      expect(robot.get_name_registry.length).to eq(5001)
    end
  end
end
