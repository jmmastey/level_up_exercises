#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'robot_name'

class RobotTest < Minitest::Test
  def test_without_name_generator
    assert Robot.new.name
  end

  def test_uses_name_generator
    generator = -> { "AA000" }
    assert Robot.new(name_generator: generator).name == "AA000"
  end

  def test_eventually_rejects_badly_formatted_name
    generator = -> { "A" }
    assert_raises(RobotNameError) { Robot.new(name_generator: generator).name }
  end

  def test_eventually_rejects_duplicate_name
    generator = -> { "BB111" }
    assert Robot.new(name_generator: generator).name == "BB111"
    assert_raises(RobotNameError) { Robot.new(name_generator: generator) }
  end

  def test_retries_name_generation_on_first_collision
    each_name = %w(CC222 CC222 DD333).each
    generator = -> { each_name.next }
    assert Robot.new(name_generator: generator).name == "CC222"
    assert Robot.new(name_generator: generator).name == "DD333"
  end

  def test_retries_name_generation_on_first_badly_formatted_name
    each_name = %w(E EE4444).each
    generator = -> { each_name.next }
    assert Robot.new(name_generator: generator).name == "EE4444"
  end
end
