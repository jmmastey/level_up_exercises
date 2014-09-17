require "rspec"

require_relative "../src/wire_box"

describe WireBox do
  let(:colors) do
    %w(red blue green yello).map(&:to_sym)
  end

  context "upon creation" do
    let(:box) do
      WireBox.new(wire_colors: colors, safe_wire: :green)
    end

    it "should not explode when green is clipped" do
      box.snip(:green)
      expect(box).not_to be_triggered
    end
  end
end
