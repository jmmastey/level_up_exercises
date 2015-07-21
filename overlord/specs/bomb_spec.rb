
require_relative '../bomb'

describe 'Bomb' do
  let(:bomb) { Bomb.new }
  let(:armed_bomb) { bomb.boot.arm('1234') }
  describe '#new' do
    context 'when initialized bomb' do
      it 'should not be nil' do
        expect(bomb).not_to be_nil
      end
      it 'should not be activated' do
        expect(bomb.active?).to eq(false)
      end
      it 'should not be armed' do
        expect(bomb.armed?).to eq(false)
      end
      it 'should have a default activation code of 1234' do
        expect(bomb.activation_code).to eq('1234')
      end
      it 'should have a default deactivation code of 0000' do
        expect(bomb.deactivation_code).to eq('0000')
      end
    end
  end

  describe '#load'
  context 'when loading a bomb' do
    it 'should allow loading a bomb with the default de/activation codes' do
      expect(bomb.boot).not_to be_nil
      expect(bomb.active?).to be true
    end
    it 'should allow supplying custom activation code only' do
      expect(bomb.boot('4444')).not_to be_nil
      expect(bomb.activation_code).to eq('4444')
      expect(bomb.deactivation_code).to eq('0000')
      expect(bomb.active?).to be true
    end
    it 'should allow supplying custom deactivation code only' do
      expect(bomb.boot(nil, '9999')).not_to be_nil
      expect(bomb.activation_code).to eq('1234')
      expect(bomb.deactivation_code).to eq('9999')
      expect(bomb.active?).to be true
    end

    it 'should allow supplying both activation and deactivation codes' do
      expect(bomb.boot('4444', '9999')).not_to be_nil
      expect(bomb.activation_code).to eq('4444')
      expect(bomb.deactivation_code).to eq('9999')
      expect(bomb.active?).to be true
    end

    it 'should allow supplying invalid custom activation the code should not be set' do
      expect(bomb.boot(activation_code: '4AA4')).not_to be_nil
      expect(bomb.activation_code).to eq('1234')
      expect(bomb.deactivation_code).to eq('0000')
      expect(bomb.active?).to be false
    end
  end

  describe '#arm'
  context 'when arming a bomb with the correct activation code it should be armed' do
    it 'should allow arming a bomb with correct code' do
      expect(bomb.boot.armed?).to be false
      expect(bomb.arm('1234').armed?).to be true
    end

    it 'should not arm a bomb with incorrect code' do
      expect(bomb.boot.armed?).to be false
      expect(bomb.arm('2134').armed?).to be false
    end

    it 'should keep a bomb armed if another arming code is provided' do
      expect(bomb.boot.armed?).to be false
      expect(bomb.arm('1234').arm('2134').armed?).to be true
    end
  end

  describe '#disarm'
  context 'when disarming a bomb with the correct activation code it should be armed' do
    it 'should allow disarming a bomb with correct code' do
      expect(bomb.boot.arm('1234').disarm('0000').armed?).to be false
    end

    it 'should should not disarm a bomb with incorrect code' do
      expect(bomb.boot.arm('1234').disarm('1111').armed?).to be true
    end
  end

  describe '#detonated'
  context 'putting in the wrong deactivation code three times should detonate' do
    it 'should not detonate after 1 failed attempt' do
      expect(armed_bomb.disarm('3').detonated).to be false
    end

    it 'should not detonate after 2 failed attempts' do
      expect(armed_bomb.disarm('3').disarm('3').detonated).to be false
    end

    it 'should detonate after 3 failed attempts' do
      expect(armed_bomb.disarm('3').disarm('3').disarm('3').detonated).to be true
    end
  end
end
