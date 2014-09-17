require "rspec"

require_relative "../src/wire_box"

describe WireBox do
  let(:not_exploded) { "not exploded!" }
  let(:exploded) { "exploded!" }
  let(:explode) do
    ->(){ not_exploded.replace(exploded) }
  end

  let(:colors) do
    %w(red blue green yello).map(&:to_sym)
  end

  context "upon creation" do
    let(:box) do
      box = WireBox.new(wire_colors: colors, safe_wire: :green)
      box.on_bad_snip(explode)
      box
    end

    it "should not explode when green is clipped" do
      box.snip(:green)
      test = not_exploded
      explode.call
      expect(test).to eq(test)
    end
  end
end
