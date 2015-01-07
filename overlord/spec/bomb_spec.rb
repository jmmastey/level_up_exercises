require_relative '../bomb.rb'

describe Bomb do
	let(:bomb) { Bomb.new }

	it "adds 1 to invalid count when an invalid code is entered" do
		bomb.deactivate(1111)
		expect(bomb.invalid_count).to eq(1)
	end

	it "should not detonate after 1 invalid code is entered" do
		bomb.deactivate(1111)
		expect(bomb.detonated?).to eq(false)
	end
end