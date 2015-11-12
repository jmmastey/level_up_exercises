require './robot_name'
require 'test/unit'

class TestRobot < Test::Unit::TestCase
  def test_initialize
    robot1 = Robot.new
    assert_not_nil(robot1)
    assert_not_nil(robot1.name)

    generator = -> { 'AA111' }

    robot2 = Robot.new(name_generator: generator)
    assert_not_nil(robot2)
    assert_not_nil(robot2.name)

    robot3 = Robot.new(name_generator: generator)
    assert_not_nil(robot3)
    assert_not_nil(robot3.name)

    expected = true
    actual = robot3.name != robot2.name
    assert_equal(expected, actual, "robot names should not be equal")

    actual = robot3.name != robot1.name
    assert_equal(expected, actual, "robot names should not be equal")

    actual = robot2.name != robot1.name
    assert_equal(expected, actual, "robot names should not be equal")
  end

  def test_create_random_generator
    robot = Robot.new

    generator1 = robot.create_random_generator
    assert_not_nil(generator1)

    generator2 = robot.create_random_generator
    assert_not_nil(generator2)

    expected = true
    actual = generator1.call != generator2.call
    assert_equal(expected, actual, "Generators from same Robot " \
      "instance should not be equal")
  end

  def test_generate_name
    robot = Robot.new
    generator = -> { 'BC123' }

    name = robot.generate_name(generator)
    assert_not_nil(name)

    actual = name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    assert_not_nil(actual, "Name should start with 2 alpha and end with " \
      "3 numeric chars")

    generator = -> { 'AA111' }
    robot = Robot.new(name_generator: generator)
    name = robot.generate_name(generator)

    actual = name =~ /[[:alpha:]]{2}[[:digit:]]{3}/
    assert_not_nil(actual, "Name should start with 2 alpha and end with " \
      "3 numeric chars")
  end

  def test_is_invalid_name
    robot = Robot.new
    mock_name = robot.name.split("")[1] + robot.name.split("")[0] + "123"
    is_invalid = robot.invalid_name?(mock_name)
    assert_equal(false, is_invalid, "First attempt at name " \
      "should not be invalid")
  end
end
