require_relative '../bomb'

describe Bomb do

  context 'instantiated with codes' do
    let(:bomb) { Bomb.new(activation_code: "8888", deactivation_code: "2222") }

    it 'is instantiated with user activation and deactivation codes' do
      expect(bomb.activation_code).to eq("8888")
      expect(bomb.deactivation_code).to eq("2222")
    end
  end

  context 'after instantiation' do
    let(:bomb) { Bomb.new(activation_code: "8888", deactivation_code: "2222") }

    it 'has an initial status of inactive' do
      expect(bomb.status).to eq(:inactivated)
    end
  end
end

