class NameGenerator
  DEFAULT_NUM_CHARS = 2
  DEFAULT_NUM_NUMS = 3

  def initialize(num_chars = DEFAULT_NUM_CHARS, num_nums = DEFAULT_NUM_NUMS)
    @num_chars = num_chars
    @num_nums = num_nums
  end

  def call
    name = ""
    num_chars.times { name << generate_char }
    num_nums.times { name << generate_num }
    name
  end

  private

  attr_reader :num_chars, :num_nums

  def generate_char
    [*'A'..'Z'].sample
  end

  def generate_num
    rand(10).to_s
  end
end
