class NameGenerator
  def generate_name(num_chars, num_nums)
    name = ""
    num_chars.times { name += generate_char }
    num_nums.times { name += generate_num }
    name
  end

  private

  def generate_char
    [*'A'..'Z'].sample
  end

  def generate_num
    rand(10).to_s
  end
end
