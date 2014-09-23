#!/usr/bin/ruby2.0

# Killer facts about triangles AWW YEAH
class Triangle
  attr_accessor :side1, :side2, :side3

  def initialize(side1, side2, side3)
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def recite_facts
    recite_categorical_facts
    recite_angle_facts
  end

  def to_s
    "Triangle with sides: #{@side1} #{@side2} #{@side3}"
  end

  private
  def equilateral?
    (@side1 == @side2) && (@side2 == @side3)
  end

  def isosceles?
    [@side1, @side2, @side3].uniq.length <= 2
  end

  def scalene?
    !(equilateral? || isosceles?)
  end

  def recite_categorical_facts
    puts 'This triangle is equilateral!' if equilateral?
    puts 'This triangle is isosceles! Also, that word is hard to type.' if isosceles?
    puts 'This triangle is scalene and mathematically boring.' if scalene?
    puts 'This triangle is also a right triangle!' if angles.include? 90
  end

  def recite_angle_facts
    puts 'The angles of this triangle are ' + angles.join(",")
  end

  def included_angle(legA, legB, opp)
    radians = Math.acos((legA**2 + legB**2 - opp**2) / (2.0 * legA * legB))
    to_degrees(radians)
  end

  def angles
    angleA = included_angle(@side2, @side3, @side1)
    angleB = included_angle(@side1, @side3, @side2)
    angleC = included_angle(@side1, @side2, @side3)
    [angleA, angleB, angleC]
  end

  def to_degrees(rads)
    return (rads * 180 / Math::PI).round
  end
end
  
triangles = []
triangles << [5, 5, 5]
triangles << [5, 12, 13]

triangles.each do |sides|
  triangle = Triangle.new(*sides)
  puts triangle
  triangle.recite_facts
  puts
end
