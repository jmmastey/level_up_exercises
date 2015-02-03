require './spec/spec_helper.rb'

RSpec.describe Interface do
  let(:default_activation_code) { 6969 }
  let(:default_deactivation_code) { 6969 }
  subject(:interface) { Interface.new }

  describe "#virtus" do
    describe "#attribute" do
      [:activation_code, :deactivation_code, :disarming_code, :timer, :attempts].each do |attribute|
        it "has an attribute of #{attribute}" do
          expect(interface.attributes).to include(attribute)
        end
      end
    end
  end

  describe "#validations" do
    describe "#validates_format_of" do
      context "when it passes the validation" do
        it { is_expected.to allow_value(rand(1000..9999), :activation_code)}
        it { is_expected.to allow_value(rand(1000..9999), :deactivation_code)}
        it { is_expected.to allow_value(rand(1000..9999), :timer)}
        it { is_expected.to allow_value(rand(1000..9999), :attempts)}
      end
      context "when it fails the validation" do
        it { is_expected.to_not allow_value(Faker::Lorem.characters(10), :activation_code)}
        it { is_expected.to_not allow_value(Faker::Lorem.characters(10), :deactivation_code)}
        it { is_expected.to_not allow_value(Faker::Lorem.characters(10), :timer)}
        it { is_expected.to_not allow_value(Faker::Lorem.characters(10), :attempts)}
      end
    end
    describe "#validates_presence_of" do
      describe "#disarming_code" do
        context "when the condition (if payload.state == 'activated') is met" do
          before :each do
            interface.turn_on(default_activation_code)
          end
          context "when it passes the validation" do
            it { is_expected.to allow_value(rand(1000..9999), :disarming_code)}
          end
          context "when it fails the validation" do
            it { is_expected.to_not allow_value(nil, :disarming_code)}
            it { is_expected.to_not allow_value("", :disarming_code)}
          end
        end
        context "when the condition (if payload.state == 'activated') is not met" do
          it { is_expected.to allow_value(nil, :disarming_code)}
          it { is_expected.to allow_value("", :disarming_code)}
        end
      end
    end
  end

  describe "#configure_settings" do
    context "when an attribute is set" do
      { :activation_code => rand(1000..6000), :deactivation_code => rand(1000..6000),
        :timer => rand(10..29), :attempts => rand(1..2) }.each do |attribute, value|
        it "changes the value of #{attribute} to #{value}" do
          interface.configure_settings(attribute => value)
          expect(interface.send(attribute)).to eq(value)
        end
      end
    end
    context "when an attribute is not set" do
      { :activation_code => 6969, :deactivation_code => 6969,
        :timer => 30, :attempts => 3 }.each do |attribute, value|
        it "does not change the default value of #{attribute} from #{value}" do
          interface.configure_settings(nil)
          expect(interface.send(attribute)).to eq(value)
        end
      end
    end
  end

  describe "#turn_on" do
    context "when valid_activation_code? == true" do
      context "and it matches the default activation code" do
        let(:code) { 6969 } # default code
        before :each do
          interface.configure_settings(nil)
        end
        it "returns true" do
          expect(interface.turn_on(code)).to be_truthy
        end
        it "changes the payload state to activated" do
          interface.turn_on(code)
          expect(interface.payload.state).to eq("activated")
        end
      end
      context "and it matches a set activation code" do
        let(:code) { rand(7000..9999) }
        before :each do
          interface.configure_settings(:activation_code => code)
        end
        it "return true" do
          interface.configure_settings(:activation_code => code)
          expect(interface.turn_on(code)).to be_truthy
        end
        it "changes the payload state to activated" do
          interface.turn_on(code)
          expect(interface.payload.state).to eq("activated")
        end
      end
    end
    context "when valid_activation_code? == false" do
      context "and it does not match the default activation code" do
        let(:code) { rand(1000..6000) }
        before :each do
          interface.configure_settings(nil)
        end
        it "returns false" do
          interface.configure_settings(nil)
          expect(interface.turn_on(code)).to be_falsey
        end
        it "does not change the payload state" do
          state = interface.payload.state
          interface.turn_on(code)
          expect(interface.payload.state).to eq(state)
        end
      end
      context "and it does not match the set activdation code" do
        let(:code) { rand(1000..6000) }
        before :each do
          interface.configure_settings(:activation_code => rand(8000..10000))
        end
        it "returns false" do
          expect(interface.turn_on(code)).to be_falsey
        end
        it "does not change the payload state" do
          state = interface.payload.state
          interface.turn_on(code)
          expect(interface.payload.state).to eq(state)
        end
      end
    end
  end

  describe "#deploy" do
    before :each do
      interface.turn_on(default_activation_code)
    end
    context "when validate! == true" do
      let(:code) { rand(1000..9999) }
      before :each do
        interface.configure_settings(:disarming_code => code)
        interface.deploy
      end
      it "has a disarming code" do
        expect(interface.disarming_code).to be_truthy
      end
      it "changes the payload.state == 'armed'" do
        expect(interface.payload.state).to eq('armed')
      end
    end
    context "when validate! == false" do
      let(:code) { nil }
      it "raises an error when deploying" do
        expect { interface.deploy }.to raise_error
      end
      it "does not have a disarming code" do
        expect(interface.disarming_code).to be_nil
      end
      it "does not change the payload.state to 'armed'" do
        expect(interface.payload.state).to_not eq('armed')
      end
    end
  end

  describe "#disable" do
    let(:code) { rand(1000..9999) }
    before :each do
      interface.turn_on(default_activation_code)
      interface.configure_settings(:disarming_code => code)
      interface.deploy
    end
    context "when valid_sdisarming_code? == true" do
      context "and it matches the disarming code" do
        it "returns true" do
          expect(interface.disable(code)).to be_truthy
        end
        it "changes the payload.state to 'disarmed'" do
          interface.disable(code)
          expect(interface.payload.state).to eq('disarmed')
        end
      end
    end
    context "when valid_disarming_code? == false" do
      context "and it does not  the disarming code" do
        # I just did a minus 1 on whatever the code is
        it "returns false" do
          expect(interface.disable(code - 1)).to be_falsey
        end
        it "does not change the payload.state to 'disarmed'" do
          interface.disable(code - 1)
          expect(interface.payload.state).to_not eq('disarmed')
        end
      end
    end
  end

  describe "#turn_off" do
    let(:deactivation_code) { rand(1000..9999) }
    let(:disarming_code) { rand(1000..9999) }
    before :each do
      interface.turn_on(default_activation_code)
      interface.configure_settings(:deactivation_code => deactivation_code,
                                   :disarming_code => disarming_code)
      interface.deploy
      interface.disable(disarming_code)
    end
    context "when valid_deactivation_code? == true" do
      context "when it matches the default deactivation_code" do
      let(:deactivation_code) { nil } # by leaving this nil, it will use the default
        it "returns true" do
          expect(interface.turn_off(default_deactivation_code)).to be_truthy
        end
        it "changes the payload.state to 'deactivated'" do
          interface.turn_off(default_deactivation_code)
          expect(interface.payload.state).to eq('deactivated')
        end
      end
      context "when it matches the deactivation_code" do
        it "returns true" do
          expect(interface.turn_off(deactivation_code)).to be_truthy
        end
        it "changes the payload.state to 'deactivated'" do
          interface.turn_off(deactivation_code)
          expect(interface.payload.state).to eq('deactivated')
        end
      end
    end
    context "when valid_deactivation_code? == false" do
      it "returns false" do
        expect(interface.turn_off(deactivation_code - 1)).to be_falsey
      end
      it "does not change the payload.state to 'deactivated'" do
        interface.turn_off(deactivation_code - 1)
        expect(interface.payload.state).to_not eq('deactivated')
      end
    end
  end

  # Private Methods
  #
  # Ideally you do not test Private methods with integration testing
  # you could do this in a unit test capacity but then again, Svajone likes testing.
  # But really, private method testing in Rails convention is not a good thing to do.

  describe "#valid_activation_code?" do
    context "when code is valid" do
      it "returns true" do
        expect(interface.send(:valid_activation_code?, 6969)).to be_truthy
      end
    end
    context "when code is not valid" do
      it "returns false" do
        expect(interface.send(:valid_activation_code?, 6666)).to be_falsey
      end
    end
  end

  describe "#valid_deactivation_code?" do
    context "when code is valid" do
      it "returns true" do
        expect(interface.send(:valid_deactivation_code?, 6969)).to be_truthy
      end
    end
    context "when code is not valid" do
      it "returns false" do
        expect(interface.send(:valid_deactivation_code?, 6666)).to be_falsey
      end
    end
  end

  describe "#validate!" do
    context "when valid? == true" do
      let(:interface) { Interface.new } # this is assumed to be valid
      it "returns true" do
        expect(interface.send(:validate!)).to be_truthy
      end
      it "does not raise an error" do
        expect { interface.send(:validate!) }.to_not raise_error
      end
    end
    context "when valid? == false" do
      it "raises an error" do
        interface.timer = 'asdsada'
        expect { interface.send(:validate!) }.to raise_error
      end
    end
  end
end
