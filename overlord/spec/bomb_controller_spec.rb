require_relative "../lib/bomb_controller"
require_relative "_helpers.rb"

describe BombController do
  let(:controller) do
    controller = BombController.new
    controller.wire_box = get_test_wire_box
    controller
  end

  it "can initialize without a code" do
    controller
  end

  it "can initialize with an activation and deactivation code" do
    controller = BombController.new("1111", "2222")
    expect(controller.activation_code).to eq("1111")
    expect(controller.deactivation_code).to eq("2222")
  end

  it "is inactive when initialized" do
    expect(controller.state).to eq(:inactive)
  end

  describe "#default_activation_code" do
    it "is the activation code of a bomb initialized without one" do
      default = controller.default_activation_code
      expect(default).to eq(controller.activation_code)
    end

    it "is 1234" do
      expect(controller.default_activation_code).to eq("1234")
    end
  end

  describe "#default_deactivation_code" do
    it "is the deactivation code of a bomb initialized without one" do
      default = controller.default_deactivation_code
      expect(default).to eq(controller.deactivation_code)
    end

    it "is 0000" do
      expect(controller.default_deactivation_code).to eq("0000")
    end
  end

  describe "#enter_code" do
    it "accepts a 4-digit code or time" do
      controller.enter_code("1111")
    end

    it "raises an argument error if the code is not in a valid format" do
      expect { controller.enter_code("Dog") }.to raise_error(ArgumentError)
    end

    context "When bomb is inactive," do
      it "starts the activation process when the activation code is entered" do
        controller.enter_code(controller.default_activation_code)
        expect(controller.state).to eq(:activating)
      end

      it "sets message to Invalid Code if code is invalid" do
        controller.enter_code("1111")
        expect(controller.message.downcase).to include("invalid code")
      end

      it "does nothing when the code is blank" do
        expect { controller.enter_code("") }.not_to raise_error
        expect(controller.state).to eq(:inactive)
      end
    end

    context "When the bomb is activating," do
      let(:controller_for_context) do
        controller.enter_code(controller.default_activation_code)
        controller
      end

      it "cancels the activation process when nothing is entered" do
        controller_for_context.enter_code("")
        expect(controller_for_context.state).to eq(:inactive)
      end

      it "activates the bomb with a timer set to xx minutes and yy seconds for code xxyy" do
        controller_for_context.enter_code("0400")
        expect(controller_for_context.state).to eq(:active)

        expect(controller_for_context.timer.duration).to eq(240)
      end
    end

    context "When the bomb is activated," do
      let(:controller_for_context) do
        controller.enter_code(controller.default_activation_code)
        controller.enter_code("0400")
        controller
      end

      it "deactivates the bomb when the deactivation code is entered" do
        controller_for_context.enter_code(controller.default_deactivation_code)
        expect(controller_for_context.state).to eq(:inactive)
      end

      it "ignores the activation code" do
        3.times { controller_for_context.enter_code(controller.default_activation_code) }
        expect(controller_for_context.state).to eq(:active)
      end

      it "sets message to Invalid Code if an invalid code is entered" do
        controller_for_context.enter_code("3333")
        expect(controller_for_context.message.downcase).to include("invalid code")
      end

      it "detonates after 3 invalid attempts" do
        2.times { controller_for_context.enter_code("3333") }
        expect(controller_for_context.state).to eq(:active)

        controller_for_context.enter_code("3333")
        expect(controller_for_context.state).to eq(:exploded)
      end
    end

    context "When the bomb is disabled," do
      let(:controller_for_context) do
        disarming_wires = controller.wire_box.disarm_wires
        disarming_wires.each(&:snip)
        controller
      end

      it "raises a runtime error" do
        expect { controller_for_context.enter_code("1111") }.to raise_error(RuntimeError)
      end
    end

    context "When the bomb is exploded," do
      let(:controller_for_context) do
        controller.enter_code(controller.default_activation_code)
        controller.enter_code("0400")
        3.times { controller.enter_code("3333") }
        controller
      end

      it "raises an error" do
        expect { controller_for_context.enter_code("3333") }.to raise_error(RuntimeError)
      end
    end
  end

  describe "#timer" do
    it "is nil when the controller is initialized" do
      expect(controller.timer).to be_nil
    end
  end
end
