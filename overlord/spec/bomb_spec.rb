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

  describe '#validate_numericality' do

    context 'user code is an empty string' do
      it 'creates bomb with default activation code' do
        bomb = Bomb.new(activation_code: "", deactivation_code: "2222")
        expect(bomb.activation_code).to eq("1234")
        expect(bomb.deactivation_code).to eq("2222")
      end

      it 'creates bomb with default deactivation code' do
        bomb = Bomb.new(activation_code: "9999", deactivation_code: "")
        expect(bomb.activation_code).to eq("9999")
        expect(bomb.deactivation_code).to eq("0000")
      end
    end

    context 'user code is a non-numeric string' do
      it 'creates bomb with default activation code' do
        bomb = Bomb.new(activation_code: "aaaa", deactivation_code: "2222")
        expect(bomb.activation_code).to eq("1234")
        expect(bomb.deactivation_code).to eq("2222")
      end

      it 'creates bomb with default deactivation code' do
        bomb = Bomb.new(activation_code: "9999", deactivation_code: "aaaa")
        expect(bomb.activation_code).to eq("9999")
        expect(bomb.deactivation_code).to eq("0000")
      end
    end
  end

  context 'after instantiation' do
    let(:bomb) { Bomb.new(activation_code: "8888", deactivation_code: "2222") }

    it 'has an initial status of deactivated' do
      expect(bomb.status).to eq(:deactivated)
    end

    describe '#activate' do
      it 'will change the bomb status to activate' do
        bomb.activate
        expect(bomb.status).to eq(:active)
      end
    end

    describe '#deactivate' do
      it 'will change the bomb status to deactivated' do
        bomb.activate
        bomb.deactivate
        expect(bomb.status).to eq(:deactivated)
      end

      context 'bomb deactivates' do
        it 'will reset incorrect_deactivation_attempts' do
          bomb.incorrect_deactivation_attempts = 2
          bomb.deactivate
          expect(bomb.incorrect_deactivation_attempts).to be_zero
        end
      end
    end

    describe '#explode' do
      it 'will make the bomb explode' do
        bomb.explode!
        expect(bomb.status).to eq(:exploded)
      end
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
    end

    describe '#incorrect_code_entry' do

      context 'code does not match the activation or deactivation code' do
        it 'will increment the incorrect attempt tracker' do
          bomb.incorrect_attempt
          expect(bomb.incorrect_deactivation_attempts).to eq(1)
        end
      end

      context 'maximum number of incorrect attempts not exceeded' do
        it 'will change bomb status to active' do
          bomb.status = :active
          bomb.incorrect_attempt
          expect(bomb.status).to eq(:active)
        end
      end

      context 'maximum number of incorrect attempts exceeded' do
        it 'will change bomb status to exploded' do
          bomb.incorrect_attempt
          bomb.incorrect_attempt
          bomb.incorrect_attempt
          expect(bomb.status).to eq(:exploded)
        end
      end
    end
  end
end
