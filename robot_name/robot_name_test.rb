require 'minitest/autorun'
begin
  require_relative 'robot_name'
rescue LoadError => e
  puts "\n\n#{e.backtrace.first} #{e.message}"
  puts DATA.read
  exit 1
end

class RobotTest < MiniTest::Unit::TestCase
  def test_robot_name_exists
    robot = Robot.new
    assert !robot.name.nil?, robot.name
  end
end
