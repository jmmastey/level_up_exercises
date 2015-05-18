require 'pry'
require './bomb.rb'

describe Bomb do
  def random_code(num = 4)
    new_code = ''
    loop do
      new_code = ''
      num.times { new_code += rand(9).to_s }
      break unless @security_codes.include? new_code
    end
    new_code
  end

  def activate_bomb
    bomb.activate(activation_code)
  end

  def deactivate_bomb
    bomb.deactivate(deactivation_code)
  end

  def explode_bomb
    3.times { bomb.deactivate(random_code) }
  end

  shared_examples 'mutable bomb' do
    subject(:bomb) { Bomb.new(@security_codes[:activate], @security_codes[:deactivate]) }
    subject(:activation_code) { @security_codes[:activate] }
    subject(:deactivation_code) { @security_codes[:deactivate] }

    it 'state should be in "inactive" state' do
      expect(bomb.status).to eq('inactive')
    end

    it 'should be in "active" state when we enter the correct activation code' do
      activate_bomb
      expect(bomb.status).to eq('active')
    end

    it 'should be in "inactive" state when we enter the correct deactivation code' do
      activate_bomb
      deactivate_bomb
      expect(bomb.status).to eq('inactive')
    end

    it 'should be in "exploded" state when in "active" state and an incorrect deactivation code was entered 3 times consecutively' do
      activate_bomb
      explode_bomb
      expect(bomb.status).to eq('exploded')
    end

    it 'should remain in "inactive" state when we enter the incorrect activation code' do
      bomb.activate(random_code)
      expect(bomb.status).to eq('inactive')
    end

    it 'should remain in "active" state when we enter the incorrect deactivation code' do
      activate_bomb
      bomb.deactivate(random_code)
      expect(bomb.status).to eq('active')
    end

    it 'should remain in "exploded" state when we enter the correct activation code' do
      activate_bomb
      explode_bomb
      activate_bomb
      expect(bomb.status).to eq('exploded')
    end

    it 'should remain in "exploded" state when we enter the correct deactivation code' do
      activate_bomb
      explode_bomb
      deactivate_bomb
      expect(bomb.status).to eq('exploded')
    end

    it 'should remain in "exploded" state when we enter the incorrect activation code' do
      activate_bomb
      explode_bomb
      bomb.activate(random_code)
      expect(bomb.status).to eq('exploded')
    end

    it 'should remain in "exploded" state when we enter the correct deactivation code' do
      activate_bomb
      explode_bomb
      bomb.deactivate(random_code)
      expect(bomb.status).to eq('exploded')
    end
  end

  before(:all) do
    @security_codes = {
      activate: '1234', # default
      deactivate: '0000', # default
    }
  end

  context 'using default security codes' do
    it_behaves_like 'mutable bomb' do
    end
  end

  context 'using custom security codes' do
    it_behaves_like 'mutable bomb' do
      before(:all) do
        @security_codes = {
          activate: random_code,
          deactivate: random_code,
        }
      end
    end
  end
end
