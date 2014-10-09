require 'rspec'
require 'bomb'

describe Bomb do
  subject(:bomb) { Bomb.new }

  let(:err_msg) { "code must be 4 numbers" }
  let(:valid_code) { "1234" }
  let(:short_code) { "123" }
  let(:empty_code) { "" }
  let(:alpha_code) { "asdf" }
  let(:invalid_code) { "5678" }

  def activate(activation_code, deactivation_code)
    bomb.activate(activation_code, deactivation_code)
  end

  context '.activate' do
    context 'happy path' do
      it 'when using valid code' do
        activate(valid_code, valid_code)
        is_expected.to be_activated
      end
    end

    context 'sad path' do
      it 'with no activation code' do
        expect { activate(empty_code, valid_code) }.to raise_error(/#{err_msg}/)
      end

      it 'with no activation code' do
        expect { activate(empty_code, valid_code) }.to raise_error(/#{err_msg}/)
      end

      it 'with no deactivation code' do
        expect { activate(valid_code, empty_code) }.to raise_error(/#{err_msg}/)
      end

      it 'with short activation code' do
        expect { activate(short_code, valid_code) }.to raise_error(/#{err_msg}/)
      end

      it 'with short deactivation code' do
        expect { activate(valid_code, short_code) }.to raise_error(/#{err_msg}/)
      end

      it 'with non numeric activation code' do
        expect { activate(alpha_code, valid_code) }.to raise_error(/#{err_msg}/)
      end

      it 'with non numeric deactivation code' do
        expect { activate(valid_code, alpha_code) }.to raise_error(/#{err_msg}/)
      end

    end

    context 'error path' do
      it 'when already activated' do
        activate(valid_code, valid_code)
        expect { activate(valid_code, valid_code) }.to raise_error(Bomb::BombError)
      end

      it 'when already exploded' do
        activate(valid_code, valid_code)
        Bomb::MAX_ATTEMPTS.times { bomb.deactivate(invalid_code) }
        expect(bomb).to be_exploded
        expect { activate(valid_code, valid_code) }.to raise_error(Bomb::BombError)
      end

      it 'when I enter the wrong code too many times' do
        bomb.activate(valid_code, valid_code)
        Bomb::MAX_ATTEMPTS.times { bomb.deactivate(invalid_code) }
        expect(bomb).to be_exploded
      end

    end
  end

  context '.deactivate' do
    context 'happy path' do
      it 'when I enter the correct code' do
        bomb.activate(valid_code, valid_code)
        bomb.deactivate(valid_code)
        expect(bomb).not_to be_activated
        expect(bomb).not_to be_exploded
      end

      it 'when I enter the right code on the last attempt' do
        bomb.activate(valid_code, valid_code)
        (Bomb::MAX_ATTEMPTS - 1).times { bomb.deactivate(invalid_code) }
        bomb.deactivate(valid_code)
        expect(bomb).not_to be_activated
        expect(bomb).not_to be_exploded
      end

      it 'should report the number of attempts remaining' do
        bomb.activate(valid_code, valid_code)
        bomb.deactivate(invalid_code)
        expect(bomb.attempts_remaining).to eq(Bomb::MAX_ATTEMPTS - 1)
      end
    end

    context 'sad path' do
      it 'when I enter the wrong code' do
        bomb.activate(valid_code, valid_code)
        bomb.deactivate(invalid_code)
        expect(bomb).to be_activated
        expect(bomb).not_to be_exploded
      end
    end

    context 'error path' do
      it 'when exploded' do
        bomb.activate(valid_code, valid_code)
        Bomb::MAX_ATTEMPTS.times { bomb.deactivate(invalid_code) }
        expect { bomb.deactivate(valid_code) }.to raise_error(Bomb::BombError)
      end
    end
  end
end
