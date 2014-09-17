require "rspec"

require_relative "../src/wire_box"

describe WireBox do
  let(:colors) do
    %w(red blue green yello).map(&:to_sym)
  end

  context "upon creation with safe green wire" do
    let(:box) do
      WireBox.new(wire_colors: colors, safe_wire: :green)
    end

    it "should not explode when green is clipped" do
      box.snip(:green)
      expect(box).not_to be_triggered
    end

    it "should be triggered when red is clipped" do
      box.snip(:red)
      expect(box).to be_triggered
    end

    it "should be triggered when blue is clipped" do
      box.snip(:blue)
      expect(box)
    end

    it "should raise error if color not in box" do
      expect { box.snip(:purple) }.to raise_error
    end
  end
end
