require_relative '../bomb'

describe Bomb do
  context 'instantiated with no codes' do
    let(:bomb) { Bomb.new }

    it 'is instantiated with default activation and deactivation codes' do
        expect(bomb.activation_code).to eq(1234)
        expect(bomb.deactivation_code).to eq(0000)
    end
  end

  context 'instantiated with no parameters' do
    let(:bomb) { Bomb.new(activation_code: 8888, deactivation_code: 2222) }

    it 'is instantiated with user activation and deactivation codes' do
      expect(bomb.activation_code).to eq(8888)
      expect(bomb.deactivation_code).to eq(2222)
    end
  end
end

