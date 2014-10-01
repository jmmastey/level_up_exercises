require "rspec"
require_relative "descartes"

describe "Descartes" do
	subject(:descartes) { Descartes.new }
	let(:alive) { true }
	let(:dead) { false }
	
	describe "#alive_or_dead" do
		it "will be alive or dead when alive" do
			descartes.state = alive
			expect(descartes.dead? || descartes.alive?).to eq(true)
		end

		it "will be alive or dead when dead" do
			descartes.state = dead
			expect(descartes.dead? || descartes.alive?).to eq(true)
		end
	end
end
