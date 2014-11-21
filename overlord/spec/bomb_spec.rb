require_relative '../bomb'

describe Bomb do

  context 'instantiated without user codes' do
    let(:bomb) { Bomb.new }

    it 'is instantiated with default user activation and deactivation codes' do
      expect(bomb.activation_code).to eq("1234")
      expect(bomb.deactivation_code).to eq("0000")
    end
  end

  context 'instantiated with user codes' do
    let(:bomb) { Bomb.new(activation_code: "8888", deactivation_code: "2222") }

    it 'is instantiated with user activation and deactivation codes' do
      expect(bomb.activation_code).to eq("8888")
      expect(bomb.deactivation_code).to eq("2222")
    end
  end

  context 'validates user codes' do
    it 'creates bomb with default codes if given an empty string for the activation code' do
      bomb = Bomb.new(activation_code: "", deactivation_code: "2222")
      expect(bomb.activation_code).to eq("1234")
      expect(bomb.deactivation_code).to eq("2222")
    end

    it 'creates bomb with default codes if given an empty string for the deactivation code' do
      bomb = Bomb.new(activation_code: "9999", deactivation_code: "")
      expect(bomb.activation_code).to eq("9999")
      expect(bomb.deactivation_code).to eq("0000")
    end
  end

  context 'after instantiation' do
    let(:bomb) { Bomb.new(activation_code: "8888", deactivation_code: "2222") }

    it 'has an initial status of inactive' do
      expect(bomb.status).to eq(:inactivated)
    end

    describe '#activate' do
      it 'will change the bomb status to activate' do
        bomb.activate
        expect(bomb.status).to eq(:active)
      end
    end

    describe '#explode' do
      it 'will make the bomb explode' do
        bomb.explode!
        expect(bomb.status).to eq(:exploded)
      end
    end

    describe '#test_user_code' do
      it 'will return activate if the provided code matches the activation code' do
        expect(bomb.test_user_code("8888")).to eq(:activate)
      end

      it 'will return deactivate if the provided code matches the activation code' do
        expect(bomb.test_user_code("2222")).to eq(:deactivate)
      end

      it 'will return not_a_match if the provided code does not match the activation or deactivation codes' do
        expect(bomb.test_user_code("5555")).to eq(:not_a_match)
      end
    end
  end
end

