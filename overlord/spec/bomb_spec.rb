require_relative '../bomb.rb'

describe Bomb do
  let(:default_activation_code) { '1234' }
  let(:default_deactivation_code) { '0000' }

  describe '#boot' do
    context 'with default codes' do
      let(:bomb) { Bomb.new }
      before { bomb.boot }

      it 'is booted correctly' do
        expect(bomb).to be_booted
      end

      it 'has 3 attempts left' do
        expect(bomb.attempts).to eq(3)
      end
    end

    context 'with valid custom activation code' do
      let(:bomb) { Bomb.new('4189') }
      before { bomb.boot }

      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end

    context 'with valid custom codes' do
      let(:bomb) { Bomb.new('4189', '4231') }
      before { bomb.boot }

      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end

    context 'with invalid custom activation code' do
      let(:bomb) { Bomb.new('abc1') }
      before { bomb.boot }

      it 'is still in off state' do
        expect(bomb).to be_off
      end
    end
  end

  describe '#update' do
    let(:bomb) { Bomb.new('abc', '1234') }

    context 'with correct activation code' do
      before do
        bomb.update('1234', '2345')
        bomb.boot
      end

      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end

    context 'with incorrect activation code' do
      before do
        bomb.update('111a', '1234')
        bomb.boot
      end

      it 'is still off' do
        expect(bomb).to be_off
      end
    end
  end

  describe '#activate' do
    let(:bomb) { Bomb.new }
    before { bomb.boot }
    context 'with the default activation code' do
      before { bomb.activate(default_activation_code) }
      it 'is activated' do
        expect(bomb).to be_activated
      end
    end

    context 'with the incorrect activation code' do
      before { bomb.activate('1111') }
      it 'is not activated' do
        expect(bomb).to_not be_activated
        expect(bomb).to be_booted
      end
    end
  end

  describe '#deactivate' do
    let(:bomb) { Bomb.new }
    before do
      bomb.boot
      bomb.activate(default_activation_code)
    end

    context 'with the correct code' do
      before { bomb.deactivate(default_deactivation_code) }

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
      before do
        bomb.deactivate('1111')
        bomb.deactivate('2222')
        bomb.deactivate('3333')
      end

      it 'in the exploded state' do
        expect(bomb).to be_exploded
      end

      it 'has 0 attempts left' do
        expect(bomb.attempts).to eq(0)
      end
    end
  end
end
