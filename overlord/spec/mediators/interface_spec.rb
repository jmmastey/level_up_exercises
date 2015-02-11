require './spec/spec_helper.rb'

RSpec.describe Interface do
  let(:default_activation_code) { 6969 }
  let(:default_deactivation_code) { 6969 }
  subject(:interface) { Interface.new }

  describe "#virtus" do
    describe "#attribute" do
      [:boot_code, :deactivation_code].each do |attribute|
        it "has an attribute of #{attribute}" do
          expect(interface.attributes).to include(attribute)
        end
      end
    end
  end

  describe "#validations" do
    describe "#validates_presence_of" do
      describe "#disarming_code" do
        context "when the condition (if payload.state == 'activated') is met" do
          before :each do
            interface.turn_on(default_activation_code)
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
      { :disarming_code => rand(1000..6000),
        :timer => rand(10..29), :max_attempts => rand(1..2) }.each do |attribute, value|
        it "changes the value of #{attribute} to #{value}" do
          interface.configure_settings(attribute => value)
          expect(interface.payload.send(attribute)).to eq(value)
        end
      end
    end
    context "when an attribute is not set" do
      { :disarming_code => nil,
        :timer => 30, :max_attempts => 3 }.each do |attribute, value|
        it "does not change the default value of #{attribute} from #{value}" do
          interface.configure_settings(nil)
          expect(interface.payload.send(attribute)).to eq(value)
        end
      end
    end
  end

  describe "#turn_on" do
    context "when valid_boot_code? == true" do
      context "and it matches the boot code" do
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
    end
    context "when valid_boot_code? == false" do
      context "and it does not match the boo code" do
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
    let(:disarming_code) { rand(1000..9999) }
    before :each do
      interface.turn_on(default_activation_code)
      interface.configure_settings(:disarming_code => disarming_code)
      interface.deploy
      interface.disable(disarming_code)
    end
    context "when valid_deactivation_code? == true" do
      context "when it matches the deactivation_code" do
      let(:deactivation_code) { 6969 }
        it "returns true" do
          expect(interface.turn_off(default_deactivation_code)).to be_truthy
        end
        it "changes the payload.state to 'deactivated'" do
          interface.turn_off(default_deactivation_code)
          expect(interface.payload.state).to eq('deactivated')
        end
      end
    end
    context "when valid_deactivation_code? == false" do
      let(:deactivation_code) { rand(1000..6000) }
      it "returns false" do
        expect(interface.turn_off(deactivation_code - 1)).to be_falsey
      end
      it "does not change the payload.state to 'deactivated'" do
        interface.turn_off(deactivation_code)
        expect(interface.payload.state).to_not eq('deactivated')
      end
    end
  end

  describe "#count_disarming_attempts" do
    context "when the state == 'armed'" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
      end
      it "returns true" do
        expect(interface.count_disarming_attempts).to be_truthy
      end
    end
    context "when the state != 'armed'" do
      before :each do
        b = Bombs.new
        b.activate
      end
      it "returns false" do
        expect(interface.count_disarming_attempts).to be_falsey
      end
    end
  end

  describe "#max_attempts_reach?" do
    let(:max_attempts) { rand(3..5) }

    context "when (attempts == max_attempts) == true" do
      before :each do
        b = Bombs.new(:max_attempts => max_attempts)
        b.activate
        b.arm
      end
      it "returns true" do
        max_attempts.times { interface.count_disarming_attempts }
        expect(interface.max_attempts_reached?).to be_truthy
      end
    end
    context "when (attempts == max_attempts) == false" do
      before :each do
        b = Bombs.new(:max_attempts => max_attempts)
        b.activate
        b.arm
      end
      it "returns false" do
        (max_attempts - 1).times { interface.count_disarming_attempts }
        expect(interface.max_attempts_reached?).to be_falsey
      end
    end
  end

  describe "#trigger_explosion" do
    context "when state == 'armed'" do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
      end
      it "changes the state == 'detonated'" do
        interface.trigger_explosion
        expect(interface.payload.state).to eq('detonated')
      end
      it "returns true" do
        expect(interface.trigger_explosion).to be_truthy
      end
    end
    context "when state != 'armed'" do
      before :each do
        b = Bombs.new
        b.activate
      end
      it "does not changes the state == 'detonated'" do
        state = interface.payload.state
        interface.trigger_explosion
        expect(interface.payload.state).to eq(state)
      end
      it "returns false" do
        expect(interface.trigger_explosion).to be_falsey
      end
    end
  end

  describe "#destroy_payload" do
    context "when state == 'detonated' || 'disarmed' " do
      before :each do
        b = Bombs.new
        b.activate
        b.arm
        b.detonate
      end
      it "destroys the payload" do
        expect { interface.destroy_payload }.to change{ Bombs.count}.by(-1)
      end
      it "returns true" do
        expect(interface.destroy_payload).to be_truthy
      end
    end
    context "when state != 'detonated' || 'disarmed' " do
      before :each do
        b = Bombs.new
        b.activate
      end
      it "does not destroy the payload" do
        expect { interface.destroy_payload }.to_not change{ Bombs.count}
      end
      it "returns false" do
        expect(interface.destroy_payload).to be_falsey
      end
    end
  end

  # Private Methods
  #
  # Ideally you do not test Private methods with integration testing
  # you could do this in a unit test capacity but then again, Svajone likes testing.
  # But really, private method testing in Rails convention is not a good thing to do.

  describe "#add_attempts" do
    before :each do
      b = Bombs.new
      b.activate
      b.arm
    end
    it "adds an attempt (1)" do
      expect { interface.send(:add_attempts) }.to change{ interface.payload.attempts }.by(1)
    end
    it "saves the attempt on payload" do
      expect { interface.send(:add_attempts) }.to change{ Bombs.first.attempts}.by(1)
    end
  end

  describe "#get_payload" do
    let(:get_payload) { interface.send(:get_payload) }

    context "when Bomb.all is geater than 1" do
      let(:bomb) { b = Bombs.new
                   b.activate
                   Bombs.all.first
                 }

      it "returns a bomb record" do
        bomb
        expect(get_payload.bomb_id).to eq(bomb.bomb_id)
      end
    end
    context "when Bomb.all is less than 1" do
      it "returns a NEW instance of Bomb" do
        expect(get_payload).to be_an_instance_of(Bombs)
        expect(get_payload.new?).to be_truthy
      end
    end
  end

  describe "boot_code" do
    it "returns a default code of 6969" do
      expect(interface.send(:boot_code)).to eq(6969)
    end
  end

  describe "#valid_boot_code?" do
    context "when code is valid" do
      it "returns true" do
        expect(interface.send(:valid_boot_code?, 6969)).to be_truthy
      end
    end
    context "when code is not valid" do
      it "returns false" do
        expect(interface.send(:valid_boot_code?, 6666)).to be_falsey
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
        interface.turn_on(6969)
        expect { interface.send(:validate!) }.to raise_error
      end
    end
  end
end
