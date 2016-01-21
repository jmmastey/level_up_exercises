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
      # this test FAILS as expected due to bug on line 16

      prng = Random.new
      calc = WackCalculator.new(prng)

      allow(calc).to receive(:get_rand).and_return(5, 10)

      expect(calc.random_add(prng)).to eq 15
    end
  end
end
