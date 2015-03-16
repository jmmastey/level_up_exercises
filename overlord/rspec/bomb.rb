require_relative '../bomb.rb'

describe 'the bomb' do
  context 'when initializing' do
    it 'should not be active when initialized' do
      expect(Bomb.new.is_active?).to eql(false)
    end

    it 'should not be detonated when initialized' do
      expect(Bomb.new.is_detonated?).to eql(false)
    end

    it 'should have 0 deactivation attempts' do
      expect(Bomb.new.deactivation_attempts).to eql(0)
    end

    it 'should have 1234 as the default activation code' do
      expect(Bomb.new.activation_code).to eql(1234)
    end

    it 'should have 0000 as the default deactivation code' do
      expect(Bomb.new.deactivation_code).to eql(0000)
    end

    it 'should default to 1234/0000 as codes when provided invalid codes' do
      bomb = Bomb.new('aaaa','bbbb')
      expect(bomb.activation_code).to eql(1234)
      expect(bomb.deactivation_code).to eql(0000)
    end
  end

  context 'when inputting codes' do
    it 'should activate when activation code is entered' do
      bomb = Bomb.new
      activation = bomb.activate(1234)
      expect(activation).to eql(true)
      expect(bomb.is_active?).to eql(true)
    end

    it 'should do nothing when activation code is entered again' do
      bomb = Bomb.new
      bomb.activate(1234)
      activation = bomb.activate(1234)
      expect(activation).to eql(false)
      expect(bomb.is_active?).to eql(true)
    end

    it 'should do nothing when wrong activation code is entered' do
      bomb = Bomb.new
      activation = bomb.activate(1235)
      expect(activation).to eql(false)
      expect(bomb.is_active?).to eql(false)
    end

    it 'should deactivate when deactivation code is entered' do
      bomb = Bomb.new
      bomb.activate(1234)
      expect(bomb.is_active?).to eql(true)

      deactivation = bomb.deactivate(0000)
      expect(deactivation).to eql(true)
      expect(bomb.is_active?).to eql(false)
    end

    it 'should explode when deactivation code is entered incorrectly 3 times' do
      bomb = Bomb.new
      bomb.activate(1234)
      expect(bomb.is_active?).to eql(true)

      deactivation = bomb.deactivate(0001)
      expect(deactivation).to eql(false)
      expect(bomb.deactivation_attempts).to eql(1)
      expect(bomb.is_detonated?).to eql(false)

      deactivation = bomb.deactivate(0001)
      expect(deactivation).to eql(false)
      expect(bomb.deactivation_attempts).to eql(2)
      expect(bomb.is_detonated?).to eql(false)

      deactivation = bomb.deactivate(0001)
      expect(deactivation).to eql(false)
      expect(bomb.is_detonated?).to eql(true)
      expect(bomb.is_active?).to eql(false)
    end
  end

  context 'when rearming' do
    it 'should reset the deactivation_attempt counter' do
      bomb = Bomb.new
      bomb.activate(1234)
      bomb.deactivate(0001)
      
      expect(bomb.deactivation_attempts).to eql(1)
      bomb.deactivate(0000)
      bomb.activate(1234)
      expect(bomb.deactivation_attempts).to eql(0)
    end
  end
end
