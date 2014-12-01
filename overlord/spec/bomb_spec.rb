require './bomb'

describe Bomb do

  context 'instantiated without user codes' do
    let(:bomb) { Bomb.new }

    it 'is instantiated with default user activation and deactivation codes' do
      expect(bomb.activation_code).to eq("1234")
      expect(bomb.deactivation_code).to eq("0000")
    end

    it 'is instantiated with a incorrect deactivation code attempt tracker' do
      expect(bomb.incorrect_deactivation_attempts).to be_zero
    end
  end

  context 'instantiated with user codes' do
    let(:bomb) { Bomb.new(activation_code: "8888", deactivation_code: "2222") }

    it 'is instantiated with user activation and deactivation codes' do
      expect(bomb.activation_code).to eq("8888")
      expect(bomb.deactivation_code).to eq("2222")
    end
  end

  context 'instantiated with invalid user codes' do
    let(:bomb) { Bomb.new(activation_code: "", deactivation_code: "") }

    it 'is instantiated with default user activation and deactivation codes' do
      expect(bomb.activation_code).to eq("1234")
      expect(bomb.deactivation_code).to eq("0000")
    end
  end

  context 'after instantiation' do
    let(:bomb) { Bomb.new(activation_code: "8888", deactivation_code: "2222") }

    it 'has an initial status of deactivated' do
      expect(bomb.status).to eq(:deactivated)
    end

    describe '#analyze_user_code' do
      it 'will activate bomb if user code matches activation code' do
        bomb.status = :deactivated
        bomb.analyze_user_code("8888")
        expect(bomb.status).to eq(:active)
      end

      it 'will deactivate bomb if the user code matches deactivation code' do
        bomb.status = :active
        bomb.analyze_user_code("2222")
        expect(bomb.status).to eq(:deactivated)
      end

      it 'will increase incorrect_deactivation_attempt if user code is wrong' do
        bomb.status = :active
        bomb.analyze_user_code("12")
        expect(bomb.incorrect_deactivation_attempts).to eq(1)
      end
    end
  end

  context 'after explosion' do
    let(:bomb) { Bomb.new }

    it 'will give its state as exploded' do
      bomb.status = :active
      bomb.analyze_user_code("1")
      bomb.analyze_user_code("1")
      bomb.analyze_user_code("1")
      expect(bomb.exploded?).to be_truthy
    end
  end
end
