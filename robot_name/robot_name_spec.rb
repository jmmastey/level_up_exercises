require 'rspec'
require_relative 'robot_name'

describe Robot do
  it "should create a new Robot" do
    expect(Robot.new).to be_a Robot
  end

  it "should have a name of two characters and 3 numbers" do
    expect(Robot.new.name).to match(/[[:alpha:]]{2}[[:digit:]]{3}/)
  end

  it "should raise an error if two names are the same" do
    generator = -> { 'AA111' }
    Robot.new(name_generator: generator)
    expect { Robot.new(name_generator: generator) }.to raise_error(NameCollisionError) 
  end
end
