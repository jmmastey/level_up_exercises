require "rspec"

class WackCalculator
  def initialize(prng)
    @prng = prng
  end

  def get_rand
    @prng.rand(100)
  end

  def random_add(prng)
    a = get_rand
    b = get_rand

    a + a # bug here: should be adding a + b
  end
end

RSpec.describe WackCalculator do
  context "given two numbers" do
    it "returns a string with sum of numbers" do
      # this returns a false positive

      prng = Random.new

      allow(prng).to receive(:rand).and_return(21)

      calc = WackCalculator.new(prng)

      expect(calc.random_add(prng)).to eq calc.get_rand + calc.get_rand
    end
  end
end
