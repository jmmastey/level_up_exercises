require 'spec_helper.rb'
require_relative '../lib/robot_name.rb'

describe Robot do
  before :each do
    Robot.class_variable_set(:@@registry, [])
  end

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
    it "should not allow a duplicate name to be added" do
      generator = -> { 'AA111' }
      robot = Robot.new(name_generator: generator)
      expect {robot.generate_name}.to raise_error(NameCollisionError)
    end

    it "should not contain a duplicate name in the registry" do
      robot = Robot.new
      expect do
          5.times { robot.generate_name }
      end.not_to raise_error
    end

    it "should contain exactly 51 names in the registry" do
      robot = Robot.new
      50.times { robot.generate_name }
      expect(robot.get_name_registry.length).to eq(51)
    end
  end
end
