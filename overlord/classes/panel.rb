class Panel
  attr_accessor :hacked, :code, :sequence

  def initialize(code)
    @code = code
    @sequence = conv_to_binary
  end

  def hacked?
    hacked
  end

  def conv_to_binary
    decimal = @code
    (0..5).to_a.reverse.map do |idx|
      pow = 2**idx
      map_to = ((pow <= decimal) ? 1 : 0)

      decimal -= pow if pow <= decimal
      map_to
    end
  end

  def validate(binary)
    sum = binary.reverse
          .each_with_index
          .map { |bin, idx| bin * (2**idx) }
          .inject(&:+)

    sum == @code
  end

  def code=(newcode)
    @code = newcode
    @sequence = conv_to_binary
  end
end
