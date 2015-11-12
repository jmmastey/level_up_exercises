require 'rspec'
require './triangle_facts.rb'

describe Triangle do
  sides_1 = [5, 12, 13]
  sides_2 = [5, 5, 5]

  it 'test for scalene' do
    expect(Triangle.new(*sides_1).scalene?).to be true
    expect(Triangle.new(*sides_2).scalene?).to be false
  end

  it 'test for equilateral' do
    expect(Triangle.new(*sides_1).equilateral?).to be false
    expect(Triangle.new(*sides_2).equilateral?).to be true
  end

  it 'test for isosceles' do
    expect(Triangle.new(*sides_1).isosceles?).to be false
    expect(Triangle.new(*sides_2).isosceles?).to be false
  end
end
