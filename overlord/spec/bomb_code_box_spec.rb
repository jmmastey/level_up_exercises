require "rspec"

require_relative "../src/bomb_code_box"

describe BombCodeBox do
  context "upon creation" do
    let(:code_box) { BombCodeBox.new }

    it "should not be activate and not fired" do
      expect(code_box).not_to be_active
      expect(code_box).not_to be_fired
    end

    it "should be able to be activated with code" do
      code_box.activate("1234")
      expect(code_box).to be_active
    end

    it "should throw error with bad code" do
      expect { code_box.activate(01) }.to raise_error
      expect { code_box.activate("12345") }.to raise_error
      expect { code_box.activate("not int") }.to raise_error
    end
  end

  context "upon default activation" do
    let(:code_box) do
      code_box = BombCodeBox.new
      code_box.activate
      code_box
    end

    it "should be active and not fired" do
      expect(code_box).to be_active
      expect(code_box).not_to be_fired
    end

    it "should be deactivated with 1234" do
      code_box.deactivate("1234")
      expect(code_box).not_to be_active
      expect(code_box).not_to be_fired
    end
  end

  context "upon activation" do
    let(:code_box) do
      code_box = BombCodeBox.new
      code_box.activate("4321")
      code_box
    end

    it "should raise error to activate again" do
      expect { code_box.activate("4321") }.to raise_error
    end

    it "should be activate and not fired" do
      expect(code_box).to be_active
      expect(code_box).not_to be_fired
    end

    it "should be deactivated with same code" do
      code_box.deactivate("4321")
      expect(code_box).not_to be_active
      expect(code_box).not_to be_fired
    end
  end

  context "upon first wrong guess" do
    let(:code_box) do
      code_box = BombCodeBox.new
      code_box.activate("1234")
      code_box.deactivate("0000")
      code_box
    end

    it "should be active and not fired" do
      expect(code_box).to be_active
      expect(code_box).not_to be_fired
    end
  end

  context "upon second wrong guess" do
    let(:code_box) do
      code_box = BombCodeBox.new
      code_box.activate("1234")
      2.times { code_box.deactivate("0000") }
      code_box
    end

    it "should be fired and not active" do
      expect(code_box).to be_fired
      expect(code_box).not_to be_active
    end
  end

  context "upon firing" do
    let(:not_exploded) { "not exploded!" }
    let(:exploded) { "exploded!" }

    let(:explode) do
      ->() { not_exploded.replace(exploded) }
    end

    let(:code_box) do
      code_box = BombCodeBox.new
      code_box.on_fire(explode)
      code_box.activate("1234")
      2.times { code_box.deactivate("0000") }
      code_box
    end

    it "should have called the handler" do
      code_box
      expect(not_exploded).to eq(exploded)
    end

    it "should throw error on activation" do
      expect { code_box.activate("1234") }.to raise_error
    end

    it "should throw error on deactivation" do
      expect { code_box.deactivate("1234") }.to raise_error
    end
  end

  context "upon a deactivation after bad guess" do
    let(:code_box) do
      code_box = BombCodeBox.new
      code_box.activate("1234")
      code_box.deactivate("0000")
      code_box.deactivate("1234")
      code_box
    end

    it "should be deactivated" do
      expect(code_box).not_to be_active
      expect(code_box).not_to be_fired
    end

    it "should be reset" do
      code_box.activate("1234")
      code_box.deactivate("0000")
      code_box.deactivate("1234")
      expect(code_box).not_to be_active
      expect(code_box).not_to be_fired
    end
  end
end
