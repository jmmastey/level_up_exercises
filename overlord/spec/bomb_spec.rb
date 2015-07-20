require_relative '../bomb.rb'

describe Bomb do
  describe '#initialize' do
    context 'with default codes' do
      let(:bomb) { Bomb.new }
      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end

    context 'with valid custom activation code' do
      let(:bomb) { Bomb.new('4189') }
      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end

    context 'with valid custom deactivation code' do
      let(:bomb) { Bomb.new('4189', '4231') }
      it 'is booted correctly' do
        expect(bomb).to be_booted
      end
    end

    context 'with invalid custom activation code' do
      let(:bomb) { Bomb.new('abc1') }
      it 'is kept off' do
        expect(bomb).to be_off
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

  describe '#dectivate' do
    let(:bomb) { Bomb.new }

    context 'with the correct code' do
      before { bomb.deactivate('0000') }

      it 'is deactivated' do
        expect(bomb).to be_deactivated
      end
    end
  end
end
