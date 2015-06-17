require 'spec_helper'
require './bomb.rb'


def boot(bomb)
  bomb.boot
end

def activate(bomb)
  boot(bomb)
  bomb.apply_code(bomb.activation_code)
end

def dectivate(bomb)
  activate(bomb)
  bomb.apply_code(bomb.deactivation_code)
end

def explode(bomb)
  activate(bomb)
  DEFAULT_DEFUSE_ATTEMPTS.times { bomb.apply_code("ZXCVMNDFBLJADFBNAAFBADFBD") }
end

describe Bomb do
  DEFAULT_STATUS = "Offline"
  DEFAULT_BOOT_STATUS = "Inactive"
  DEFAULT_ACTIVATION_CODE = 1234
  DEFAULT_DEACTIVATION_CODE = "0000"
  DEFAULT_DEFUSE_ATTEMPTS = 3
  DEFAULT_TIMER = 10.1

  subject(:bomb) { Bomb.new }

  describe '#initialize' do
    it 'has correct initial status' do
      expect(bomb.status).to eq(DEFAULT_STATUS)
    end
  end

  describe '#boot' do
    context 'no boot parameters are given' do
      before do
        bomb.boot
      end
      it 'has correct default activation code' do
        expect(bomb.activation_code).to eq(DEFAULT_ACTIVATION_CODE)
      end

      it 'has correct default deactivation code' do
        expect(bomb.deactivation_code).to eq(DEFAULT_DEACTIVATION_CODE)
      end
    end

    context 'custom boot parameters are given' do
      before do
        bomb.boot(activation_code: 2355, deactivation_code: "FACE")
      end      
      it 'has correct default activation code' do
        expect(bomb.activation_code).to eq(2355)
      end

      it 'has correct default deactivation code' do
        expect(bomb.deactivation_code).to eq('FACE')
      end
    end

    context 'booted bombs can not be booted' do
      it 'should raise' do
        boot(bomb)
        expect { bomb.boot }.to raise_error(BootError)
      end
    end
  end

  describe '#apply_code' do
    context 'the bomb is offline' do
      it 'does not react to codes' do 
        bomb.apply_code(bomb.activation_code)
        expect(bomb.status).to eq(DEFAULT_STATUS)
      end
    end

    context 'the bomb is inactive' do
      it 'is active after applying activation code' do 
        boot(bomb)
        bomb.apply_code(bomb.activation_code)
        expect(bomb.status).to eq("Active")
      end
    end

    context 'the bomb is active' do
      before do
        activate(bomb)
      end

      it 'is active after applying default activation code' do
        bomb.apply_code(DEFAULT_ACTIVATION_CODE)
        expect(bomb.status).to eq("Active")
      end

      it 'has correct defuse attempts' do
        expect(bomb.defuse_attempts).to eq(DEFAULT_DEFUSE_ATTEMPTS)
      end

      it 'activation code does not effect defuse attempts' do 
        bomb.apply_code(DEFAULT_ACTIVATION_CODE)
        expect(bomb.defuse_attempts).to eq(3)
      end

      it 'incorrect deactivation_code results in decreased defuse attempts' do 
        bomb.apply_code("TREEBEARD")
        expect(bomb.defuse_attempts).to eq(2)
      end

      it 'explodes after too many defuse attempts' do 
        DEFAULT_DEFUSE_ATTEMPTS.times { bomb.apply_code("dd") }
        expect(bomb.status).to eq("Exploded")
      end
    end

    context 'the bomb is exploded' do
      it 'explodes after defuse attempts runs out' do
        DEFAULT_DEFUSE_ATTEMPTS.times { bomb.apply_code("dd") }
        expect(bomb.status).to eq("Exploded")
      end
    end
  end

  describe 'bomb timer' do
    it 'explodes after timer reaches zero' do
      activate(bomb)
      sleep(DEFAULT_TIMER)
      expect(bomb.status).to eq("Exploded")
    end
  end


end
