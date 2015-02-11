class Code
  attr_reader :input, :type

  def initialize(input, type)
    @input = input
    @type  = type
  end

  def to_s
    if valid?
      input
    elsif present?
      nil
    else
      default
    end
  end

  def valid?
    present? && numeric?
  end

  private

  def empty?
    input.empty?
  end

  def default
    case type
      when :activation_code
        '1234'
      when :deactivation_code
        '0000'
      when :countdown
        '30'
    end
  end

  def present?
    !empty?
  end

  def numeric?
    input.scan(/\A\d+\z/).any?
  end
end
