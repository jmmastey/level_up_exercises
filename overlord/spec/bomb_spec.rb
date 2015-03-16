autoload? 'bomb.rb'
require 'spec_helper'
require 'rspec'

describe Bomb do
  let(:bomb_default) { Bomb.new('1234', '0000') }
  let(:bomb_custom) { Bomb.new('1111', '2222') }

  describe 'Initialize with default code' do
    it 'check default activation and deactivation code' do
      expect(bomb_default.instance_variable_get(:@activation_code)).to eq('1234')
      expect(bomb_default.instance_variable_get(:@deactivation_code)).to eq('0000')
      expect(bomb_default.incorrect_attempts).to eq(0)
      expect(bomb_default.status).to eq('deactivated')
    end
  end

  describe 'Initialize with custom code' do
    it 'check custom activation and deactivation code' do
      expect(bomb_custom.instance_variable_get(:@activation_code)).to eq('1111')
      expect(bomb_custom.instance_variable_get(:@deactivation_code)).to eq('2222')
      expect(bomb_default.incorrect_attempts).to eq(0)
      expect(bomb_default.status).to eq('deactivated')
    end
  end

  describe '# check_input_code' do
    before(:each) do
      bomb_custom.check_input_code('1111')
    end

    context 'check_input_code activate bomb' do
      it 'check activate bomb' do
        expect(bomb_custom.status).to eq('activated')
      end
    end

    context 'check_input_code deactivate bomb' do
      it 'check deactivate bomb' do
        bomb_custom.check_input_code('2222')
        expect(bomb_custom.status).to eq('deactivated')
      end
    end

    context 'check_input_code 3 times with wrong deactivation code' do
      it 'check status blasted' do
        3.times { bomb_custom.check_input_code('3333')  }
        expect(bomb_custom.status).to eq('blasted')
      end
    end
  end
end
