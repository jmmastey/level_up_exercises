require 'pry'
require './bomb.rb'

describe Bomb do
  DEFAULT_ACTIVATION_CODE = '1234'
  DEFAULT_DEACTIVATION_CODE = '0000'

  def random_code(num = 4)
    loop do
      code = ''
      num.times { code += rand(9).to_s }
      return code unless [DEFAULT_ACTIVATION_CODE, DEFAULT_DEACTIVATION_CODE].include? code
    end
  end

  def activate_bomb
    bomb.activate(activation_code)
  end

  def deactivate_bomb
    bomb.deactivate(deactivation_code)
  end

  def explode_bomb
    activate_bomb
    3.times { bomb.deactivate(random_code) }
  end

  shared_examples 'mutable bomb' do
    let(:params) do
      {
        activation_code: activation_code,
        deactivation_code: deactivation_code,
      }
    end
    subject(:bomb) { Bomb.new(params) }

    context 'is initialized' do
      it 'state should be in "inactive" state upon initialization' do
        expect(bomb.status).to eq(:inactive)
      end
    end

    context 'in "inactive" state' do
      before(:example) do
        deactivate_bomb
      end

      it 'should be in "active" state when we enter the correct activation code' do
        activate_bomb
        expect(bomb.status).to eq(:active)
      end

      it 'should remain in "inactive" state when we enter the correct deactivation code' do
        deactivate_bomb
        expect(bomb.status).to eq(:inactive)
      end
    end

    context 'in "active" state' do
      before(:example) do
        activate_bomb
      end

      it 'should remain in "active" state when an incorrect deactivation code is entered once' do
        bomb.deactivate(random_code)
        expect(bomb.status).to eq(:active)
      end

      it 'should remain in "active" state when an incorrect deactivation code is entered twice consecutively' do
        2.times { bomb.deactivate(random_code) }
        expect(bomb.status).to eq(:active)
      end

      it 'should be in "exploded" state when an incorrect deactivation code was entered 3 times consecutively' do
        explode_bomb
        expect(bomb.status).to eq(:exploded)
      end
    end

    context 'in "exploded" state' do
      before(:example) do
        explode_bomb
      end

      it 'should remain in "exploded" state when we enter the correct activation code' do
        activate_bomb
        expect(bomb.status).to eq(:exploded)
      end

      it 'should remain in "exploded" state when we enter the correct deactivation code' do
        deactivate_bomb
        expect(bomb.status).to eq(:exploded)
      end

      it 'should remain in "exploded" state when we enter the incorrect activation code' do
        bomb.activate(random_code)
        expect(bomb.status).to eq(:exploded)
      end

      it 'should remain in "exploded" state when we enter the correct deactivation code' do
        bomb.deactivate(random_code)
        expect(bomb.status).to eq(:exploded)
      end
    end
  end

  context 'using default security codes' do
    it_behaves_like 'mutable bomb' do
      let(:activation_code) { DEFAULT_ACTIVATION_CODE }
      let(:deactivation_code) { DEFAULT_DEACTIVATION_CODE }
    end
  end

  context 'using custom security codes' do
    it_behaves_like 'mutable bomb' do
      let(:activation_code) { random_code }
      let(:deactivation_code) { random_code }
    end
  end
end
