class NameGenerator
  def initialize
    @generate_num = -> { rand(10) }
    @generate_char = -> { ('A'..'Z').to_a.sample }
  end

  def new_name
    "#{generate_two_chars}#{generate_three_numbers}"
  end

  private

  def generate_three_numbers
    "#{@generate_num.call}#{@generate_num.call}#{@generate_num.call}"
  end

  def generate_two_chars
    "#{@generate_char.call}#{@generate_char.call}"
  end
end
