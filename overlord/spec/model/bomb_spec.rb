require './spec/spec_helper.rb'

RSpec.describe Bomb do
  describe "#initialize" do
    it "shoud have a state of 'deactivated'" do
      bomb = Bomb.new
      expect(bomb.state).to eq('deactivated')
    end
  end

  describe "#state_machine" do
    subject(:bomb) { Bomb.new }

    describe "#states" do
      [:deactivated, :activated, :armed, :disarmed, :detonated].each do |state|
        it { expect(Bomb).to have_state(state) }
      end
    end

    describe "#event.activate" do
      it { is_expected.to have_event(:state, :activate, [:deactivated => :activated]) }
      context "when calling event.activate = true" do
        states = [:deactivated]
        states.each { |state| it { is_expected.to allow_event(:state, :activate, state) } }
      end
      context "when calling event.activate = false" do
        states = [:deactivated, :activated, :armed, :disarmed, :detonated] - [:deactivated]
        states.each { |state| it { is_expected.to_not allow_event(:state, :activate, state) } }
      end
    end

    describe "#event.arm" do
      it { is_expected.to have_event(:state, :arm, [:activated, :disarmed] => :armed) }
      context "when calling event.arm = true" do
        states = [:activated, :disarmed]
        states.each { |state| it { is_expected.to allow_event(:state, :arm, state) } }
      end
      context "when calling event.arm = false" do
        states = [:deactivated, :activated, :armed, :disarmed, :detonated] - [:activated, :disarmed]
        states.each { |state| it { is_expected.to_not allow_event(:state, :arm, state) } }
      end
    end

    describe "#event.disarm" do
      it { is_expected.to have_event(:state, :disarm, [:activated => :disarmed]) }
      context "when calling event.disarm = true" do
        states = [:activated]
        states.each { |state| it { is_expected.to allow_event(:state, :disarm, state) } }
      end
      context "when calling event.disarm = false" do
        states = [:deactivated, :activated, :armed, :disarmed, :detonated] - [:activated]
        states.each { |state| it { is_expected.to_not allow_event(:state, :disarm, state) } }
      end
    end

    describe "#deactivate" do
      it { is_expected.to have_event(:state, :deactivate, [:disarmed => :deactivated]) }
      context "when calling event.deactivate = true" do
        states = [:disarmed]
        states.each { |state| it { is_expected.to allow_event(:state, :deactivate, state) } }
      end
      context "when calling event.deactivate = false" do
        states = [:deactivated, :activated, :armed, :disarmed, :detonated] - [:disarmed]
        states.each { |state| it { is_expected.to_not allow_event(:state, :deactivate, state) } }
      end
    end

    describe "#event.detonate" do
      it { is_expected.to have_event(:state, :detonate, [:armed => :detonated]) }
      context "when calling event.detonate = true" do
        states = [:armed]
        states.each { |state| it { is_expected.to allow_event(:state, :detonate, state) } }
      end
      context "when calling event.detonate = false" do
        states = [:deactivated, :activated, :armed, :disarmed, :detonated] - [:armed]
        states.each { |state| it { is_expected.to_not allow_event(:state, :detonate, state) } }
      end
    end

  end
end
