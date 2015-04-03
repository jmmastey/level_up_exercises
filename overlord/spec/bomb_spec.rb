require_relative '../bomb.rb'

describe Bomb do
  let (:bomb) { Bomb.new }
  let (:correct_activation_code) { '1234' }
  let (:correct_deactivation_code) { '0000' }
  let (:incorrect_activation_code) { '1235' }
  let (:incorrect_deactivation_code) { '0001' }
  let (:custom_activation_code) { '4321' }
  let (:custom_deactivation_code) { '1111' }
  let (:invalid_code) { 'asdf' }

  context 'when initializing' do
    it 'is not active' do
      expect(bomb.status).to be(:inactive)
    end

    it 'has no activation attempts' do
      expect(bomb.deactivation_attempts).to eql(0)
    end

    it 'has 1234 as the default activation code' do
      expect(bomb.activation_code).to eql(correct_activation_code)
    end

    it 'has 0000 as the default deactivation code' do
      expect(bomb.deactivation_code).to eql(correct_deactivation_code)
    end

    it 'defaults to 1234/0000 as codes when provided invalid codes' do
      bomb = Bomb.new(invalid_code, invalid_code)
      expect(bomb.activation_code).to eql(correct_activation_code)
      expect(bomb.deactivation_code).to eql(correct_deactivation_code)
    end

    it 'sets a flag to let user know if the bomb is using default codes' do
      expect(bomb).to be_using_default_codes
    end

    it 'allows custom activation and deactivation codes' do
      bomb = Bomb.new(custom_activation_code, custom_deactivation_code)
      expect(bomb.activate(custom_activation_code)).to be(true)
      expect(bomb.deactivate(custom_deactivation_code)).to be(true)
    end
  end

  context 'when inputting codes' do
    describe '#activate' do
      it 'activates when activation code is entered' do
        bomb.activate(correct_activation_code)
        expect(bomb.status).to be(:active)
      end

      it 'does nothing when activation code is entered again' do
        bomb.activate(correct_activation_code)
        bomb.activate(correct_activation_code)
        expect(bomb.status).to be(:active)
      end

      it 'does nothing when wrong activation code is entered' do
        bomb.activate(incorrect_activation_code)
        expect(bomb.status).to be(:inactive)
      end
    end

    describe '#deactivate' do
      it 'deactivates when deactivation code is entered' do
        bomb.activate(correct_activation_code)
        expect(bomb.status).to be(:active)

        bomb.deactivate(correct_deactivation_code)
        expect(bomb.status).to be(:inactive)
      end

      it 'does nothing when deactivation codes are entered if bomb not active' do
        bomb.deactivate(correct_deactivation_code)
        expect(bomb.status).to be(:inactive)

        bomb.deactivate(incorrect_deactivation_code)
        expect(bomb.status).to be(:inactive)

        expect(bomb.deactivation_attempts).to be_zero
      end

      it 'explodes when deactivation code is entered incorrectly 3 times' do
        bomb.activate(correct_activation_code)

        2.times do |i|
          bomb.deactivate(incorrect_deactivation_code)
          expect(bomb.deactivation_attempts).to eq(i+1)
        end

        bomb.deactivate(incorrect_deactivation_code)
        expect(bomb.status).to be(:detonated)
      end
    end
  end

  context 'when rearming' do
    it 'resets the deactivation_attempt counter' do
      bomb.activate(correct_activation_code)
      bomb.deactivate(incorrect_deactivation_code)
      bomb.deactivate(correct_deactivation_code)
      bomb.activate(correct_activation_code)
      expect(bomb.deactivation_attempts).to be(0)
    end
  end
end
