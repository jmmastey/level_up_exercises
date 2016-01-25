require_relative "spec_helper"

describe Bomb do
  let(:act_code) { "1234" }
  let(:deact_code) { "0000" }
  let(:bad_code) { "bad_code" }
  subject(:bomb) { described_class.new(act_code, deact_code) }

  describe "#new" do
    it "creates an inactive bomb" do
      expect(bomb).to be_inactive
    end

    it "defaults the max number of failed deactivations to 3" do
      expect(bomb.max_failed_deact).to eq(3)
    end

    it "accepts a custom number of failed deactivations" do
      bomb = described_class.new(act_code, deact_code, 5)
      expect(bomb.max_failed_deact).to eq(5)
    end
  end

  describe "#enter_code" do
    subject(:enter_code) { bomb.enter_code(code) }

    shared_examples "code entering" do
      it "returns the bomb" do
        expect(bomb.enter_code(act_code)).to eq(bomb)
        expect(bomb.enter_code(bad_code)).to eq(bomb)
        expect(bomb.enter_code(deact_code)).to eq(bomb)
      end
    end

    context "when inactive" do
      include_examples "code entering"

      context "when entering the activation code" do
        let(:code) { act_code }

        it { is_expected.to be_active }
      end

      context "when entering the deactivation code" do
        let(:code) { deact_code }

        it { is_expected.to be_inactive }
      end

      context "when entering a bad code" do
        let(:code) { bad_code }

        it { is_expected.to be_inactive }
      end
    end

    context "when active" do
      before(:each) { bomb.enter_code(act_code) }

      include_examples "code entering"

      context "when entering the deactivation code" do
        let(:code) { deact_code }

        it { is_expected.to be_inactive }
      end

      context "when entering the activation code" do
        context "one time" do
          it "is active" do
            bomb.enter_code(act_code)
            expect(bomb).to be_active
          end
        end

        context "numerous times" do
          it "is active" do
            bomb.max_failed_deact.times do
              bomb.enter_code(act_code)
            end

            expect(bomb).to be_active
          end
        end
      end

      context "when entering a bad code" do
        context "up until the max number of deactivations" do
          it "is active" do
            (bomb.max_failed_deact - 1).times do
              bomb.enter_code(bad_code)
              expect(bomb).to be_active
            end
          end

          it "has a deact attmpt count of one greater than prior to attempt" do
            count = bomb.failed_deactivations
            bomb.enter_code(bad_code)
            expect(bomb.failed_deactivations).to eq(count + 1)
          end
        end

        context "past the number of deactivations" do
          it "explodes the bomb" do
            bomb.max_failed_deact.times do
              bomb.enter_code(bad_code)
            end

            expect(bomb).to be_exploded
          end
        end
      end
    end

    context "when disarmed" do
      before(:each) do
        bomb.wires = WireBundle.new(1, 3)
        bomb.wires.disarming_wires.each(&:cut)
      end

      include_examples "code entering"

      context "when entering any code" do
        it "is still disarmed" do
          bomb.enter_code(act_code)
          expect(bomb).to be_disarmed

          bomb.enter_code(bad_code)
          expect(bomb).to be_disarmed

          bomb.enter_code(deact_code)
          expect(bomb).to be_disarmed
        end
      end
    end

    context "when exploded" do
      before(:each) do
        bomb.wires = WireBundle.new(0, 1)
        bomb.wires.detonating_wires.first.cut
      end

      include_examples "code entering"

      context "when entering any code" do
        it "is still exploded" do
          bomb.enter_code(act_code)
          expect(bomb).to be_exploded

          bomb.enter_code(bad_code)
          expect(bomb).to be_exploded

          bomb.enter_code(deact_code)
          expect(bomb).to be_exploded
        end
      end
    end
  end

  describe "#timer" do
    shared_examples "not expired" do
      context "when the timer is not expired" do
        before(:each) { bomb.timer = Timer.new(5) }

        it "does not explode the bomb" do
          expect(bomb).not_to be_exploded
        end
      end
    end

    context "when the bomb isn't active" do
      include_examples "not expired"

      context "when the timer is expired" do
        before(:each) { bomb.timer = Timer.new(0) }

        it "does not explode the bomb" do
          expect(bomb).not_to be_exploded
        end
      end
    end

    context "when the bomb is active" do
      before(:each) { bomb.enter_code(act_code) }

      include_examples "not expired"

      context "when the timer is expired" do
        before(:each) { bomb.timer = Timer.new(0) }

        it "explodes the bomb" do
          expect(bomb).to be_exploded
        end
      end
    end
  end

end
