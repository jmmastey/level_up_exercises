require_relative 'spec_helper'
require 'pry'
RSpec.describe Bomb do
  let(:bomb) {Bomb.new}

  describe 'activate_code' do
    it 'returns status is active if correct activation code' do
      expect(bomb.activate_code('7655','7655')).to eq('active')
    end
  end

  describe 'activate_code' do
    it 'returns status is inactive if incorrect activation code' do
      expect(bomb.activate_code('7655','7659')).to eq('inactive')
    end
  end

  describe 'valid_boot_codes?' do
    it 'returns true if boot codes are valid' do
      expect(bomb.valid_boot_codes?('7655','8659')).to eq(true)
    end
  end

  describe 'deactivate_code' do
    it 'returns status is inactive if correct deactivation code' do
      expect(bomb.deactivate_code('4576','4576')).to eq('inactive')
    end
  end

  describe 'deactivate_code' do
    it 'returns status is active if incorrect deactivation code' do
      expect(bomb.deactivate_code('4578','4579')).to eq('active')
    end
  end

  describe 'wrong_activate_attempts' do
    it 'returns 2 if the wrong activation code is entered two times' do
      bomb.activate_code('5678','4567')
      bomb.activate_code('5678','4568')
      expect(bomb.wrong_activate_attempts).to eq(2)
    end
  end


  describe 'wrong_deactivate_attempts' do
    it 'returns 3 if the wrong deactivation code is entered three times' do
       bomb.deactivate_code('4568','4569')
       bomb.deactivate_code('4568','4561')
       bomb.deactivate_code('4567','4562')
       expect(bomb.wrong_deactivate_attempts).to eq(3)
    end
  end
end
