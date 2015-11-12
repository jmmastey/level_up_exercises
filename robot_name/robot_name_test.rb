require 'rspec'
require './robot_name.rb'

describe RobotName do
  before(:all) do
    @robot_name = RobotName.new
  end

  let (:robot_name) { @robot_name }

  describe '#alpha_char' do
    it "generates random alpha character" do
      expect(robot_name.alpha_char).not_to eq(robot_name.alpha_char)
    end
  end

  describe '#digit' do
    it "generates random digits 0..10" do
      digit = robot_name.digit
      expect(digit).to be >= 0
      expect(digit).to be <= 10
    end
  end

  describe '#invalid_name?' do
    it "validates that name is 2 alphas & 3 digits" do
      allow(robot_name).to receive(:name).and_return('333AA')
      expect(robot_name.invalid_name?).to be_truthy
    end

    it "validates that name is in registry" do
      robot_name.generate_name
      expect(robot_name.invalid_name?).to be_truthy
    end

    it "invalidates if name is correct" do
      allow(robot_name).to receive(:name).and_return('AA333')
      expect(robot_name.invalid_name?).to be_falsey
    end
  end
end
