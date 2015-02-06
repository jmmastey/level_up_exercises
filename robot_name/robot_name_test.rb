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

  def test_robot_name_conflict
    assert_raises NameCollisionError do
      generator = -> { 'AA111' }
      r1d2 = Robot.new(name_generator: generator)
      r2d2 = Robot.new(name_generator: generator)
    end
  end
end
