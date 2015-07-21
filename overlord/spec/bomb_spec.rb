require_relative '../bomb.rb'

describe Bomb do
  describe '#initialize' do
    context 'with default codes' do
      let(:bomb) { Bomb.new }
      it 'is booted correctly' do
        expect(bomb).to be_booted
      end

      it 'has 3 attempts left' do
        expect(bomb.attempts).to eq(3)
      end
    end

    context 'with valid custom activation code' do
      let(:bomb) { Bomb.new('4189') }
      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end

    context 'with valid custom codes' do
      let(:bomb) { Bomb.new('4189', '4231') }
      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end

    context 'with invalid custom activation code' do
      let(:bomb) { Bomb.new('abc1') }
      it 'is still in off state' do
        expect(bomb).to be_off
      end
    end
  end

  describe '#update_codes' do
    let(:bomb) { Bomb.new('abc', '1234') }
    let(:params) do
      {
        "activation_code" => '0000',
        "deactivation_code" => '1234',
      }
    end

    context 'with correct activation code' do
      before { bomb.update_codes(params) }
      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end
  end

  describe '#activate' do
    let(:bomb) { Bomb.new }
    context 'with the correct code' do
      before { bomb.activate('1234') }

      it 'is activated' do
        expect(bomb).to be_activated
      end
    end

    context 'with the incorrect code' do
      before { bomb.activate('1111') }

      it 'is not activated' do
        expect(bomb).to_not be_activated
        expect(bomb).to be_booted
      end
    end
  end

  describe '#deactivate' do
    let(:bomb) { Bomb.new }
    context 'with the correct code' do
      before { bomb.deactivate('0000') }

      it 'is deactivated' do
        expect(bomb).to be_deactivated
      end
    end

    context 'with the incorrect code' do
      before { bomb.deactivate('1111') }

      it 'is not deactivated' do
        expect(bomb).to_not be_deactivated
      end

      it 'has 2 attempts left' do
        expect(bomb.attempts).to eq(2)
      end
    end

    context 'with the 3 failed attempts' do
      before { bomb.deactivate('1111') }
      before { bomb.deactivate('2222') }
      before { bomb.deactivate('3333') }

      it 'in the exploded state' do
        expect(bomb).to be_exploded
      end

      it 'has 0 attempts left' do
        expect(bomb.attempts).to eq(0)
      end
    end
  end
end
