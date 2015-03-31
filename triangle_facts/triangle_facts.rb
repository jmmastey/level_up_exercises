# Killer facts about triangles AWW YEAH
class TriangleFacts
  require_relative 'triangle'

  def self.recite_facts(triangle)
    if triangle.equilateral
      puts "This triangle is equilateral!"
    elsif triangle.isosceles
      puts "This triangle is isosceles! Also, that word is hard to type."
    elsif triangle.scalene
      puts "This triangle is scalene and mathematically boring."
    end

    puts "The angles of this triangle are #{triangle.angles.join(',')}"

    puts "This triangle is also a right triangle!" if triangle.right
  end
end

TRIANGLES = [
  Triangle.new(5,5,5),
  Triangle.new(5,12,13),
]
TRIANGLES.each { |triangle|
  TriangleFacts.recite_facts(triangle)
}
