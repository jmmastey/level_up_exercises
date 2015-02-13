require_relative '../bomb'

DEFAULT_ACTIVATION_CODE = "1234"
DEFAULT_DEACTIVATION_CODE = "0000"
MAX_ATTEMPTS = 3

describe Bomb do
  subject(:bomb) { Bomb.new }
  let(:custom_act) { "1111" }
  let(:custom_deact) { "2222" }

  describe ", when building," do
    it "initially is built" do
      expect(bomb).to be_built
    end

    it "initially has the default activation and deactivation codes" do
      expect(bomb.activation_code).to eq(DEFAULT_ACTIVATION_CODE)
      expect(bomb.deactivation_code).to eq(DEFAULT_DEACTIVATION_CODE)
    end

    it "initially has 3 attempts remaining" do
      expect(bomb.attempts_remaining).to eq(MAX_ATTEMPTS)
    end

    it "will be in the built state" do
      expect(bomb.status).to eq(:built)
    end
  end

  describe ", when booting" do
    context "with the deault codes entered," do
      before(:each) do
        bomb.boot('', '')
      end

      it "will be in the deactivated state" do
        expect(bomb.status).to eq(:deactivated)
      end

      it "will have the default activation and deactivation codes" do
        expect(bomb.activation_code).to eq(DEFAULT_ACTIVATION_CODE)
        expect(bomb.deactivation_code).to eq(DEFAULT_DEACTIVATION_CODE)
      end
    end

    context "with invalid custom codes entered," do
      let(:invalid_letters) { "abcs" }
      let(:invalid_length) { "12345" }
      let(:valid_code) { "1234" }

      it "raises an exception" do
        expect { bomb.boot(valid_code, invalid_length) }.to raise_error
        expect { bomb.boot(valid_code, invalid_letters) }.to raise_error
        expect { bomb.boot(invalid_letters, valid_code) }.to raise_error
        expect { bomb.boot(invalid_length, valid_code) }.to raise_error
      end
    end

    context "with valid custom codes entered," do
      before(:each) do
        bomb.boot(custom_act, custom_deact)
      end

      it "will be in the deactivated state" do
        expect(bomb.status).to eq(:deactivated)
      end

      it "will have '1111' for the activation code" do
        expect(bomb.activation_code).to eq(custom_act)
      end

      it "will have '2222' for the deactivation code" do
        expect(bomb.deactivation_code).to eq(custom_deact)
      end
    end
  end

  describe ", when activating" do
    context "with default codes entered" do
      before(:each) do
        bomb.boot('', '')
      end

      it "will initially be in the deactive state" do
        expect(bomb.status).to eq(:deactivated)
      end

      it 'activates when the default code is entered' do
        bomb.activation_attempt(DEFAULT_ACTIVATION_CODE)
        expect(bomb.status).to eq(:activated)
      end

      it 'will be in the invalid state if the wrong code is entered' do
        bomb.activation_attempt('0000')
        expect(bomb.status).to eq(:invalid)
      end
    end

    context "with custom codes entered" do
      before(:each) do
        bomb.boot(custom_act, custom_deact)
      end

      it "will initially be in the deactivated state" do
        expect(bomb.status).to eq(:deactivated)
      end

      it 'activates when the correct code is entered' do
        bomb.activation_attempt(custom_act)
        expect(bomb.status).to eq(:activated)
      end

      it 'will be in the invalid state if the wrong code is entered' do
        bomb.activation_attempt(custom_deact)
        expect(bomb.status).to eq(:invalid)
      end

      it 'raises an exception if an invalid code is entered' do
        expect { bomb.activation_attempt("abcd") }.to raise_error
      end
    end
  end

  describe ", when deactivating" do
    context "with default codes entered" do
      before(:each) do
        bomb.boot('', '')
        bomb.activation_attempt(DEFAULT_ACTIVATION_CODE)
      end

      it "will initially be in the active state" do
        expect(bomb.status).to eq(:activated)
      end

      it 'deactivates when the default code is entered' do
        bomb.deactivation_attempt(DEFAULT_DEACTIVATION_CODE)
        expect(bomb.status).to eq(:deactivated)
      end

      it 'will be in the invalid state if the wrong code is entered once' do
        bomb.activation_attempt('0000')
        expect(bomb.status).to eq(:invalid)
      end

      it 'will be in the invalid state if the wrong code is entered twice' do
        2.times { bomb.activation_attempt('0000') }
        expect(bomb.status).to eq(:invalid)
      end

      it 'will be in the exploded state if the wrong code is entered 3 times' do
        3.times { bomb.activation_attempt('0000') }
        expect(bomb.status).to eq(:invalid)
      end

      it 'raises an exception if an invalid code is entered' do
        expect { bomb.deactivation_attempt("abcd") }.to raise_error
      end
    end

    context "with custom codes entered" do
      before(:each) do
        bomb.boot(custom_act, custom_deact)
        bomb.activation_attempt(custom_act)
      end

      it "will initially be in the active state" do
        expect(bomb.status).to eq(:activated)
      end

      it 'deactivates when the default code is entered' do
        bomb.deactivation_attempt(custom_deact)
        expect(bomb.status).to eq(:deactivated)
      end

      it 'will be in the invalid state if the wrong code is entered once' do
        bomb.activation_attempt(DEFAULT_DEACTIVATION_CODE)
        expect(bomb.status).to eq(:invalid)
      end

      it 'will be in the invalid state if the wrong code is entered twice' do
        2.times { bomb.activation_attempt(DEFAULT_DEACTIVATION_CODE) }
        expect(bomb.status).to eq(:invalid)
      end

      it 'will be in the exploded state if the wrong code is entered 3 times' do
        3.times { bomb.activation_attempt(DEFAULT_DEACTIVATION_CODE) }
        expect(bomb.status).to eq(:invalid)
      end

      it 'raises an exception if an invalid code is entered' do
        expect { bomb.deactivation_attempt("abcd") }.to raise_error
      end
    end
  end
end
