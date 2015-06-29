class NameGenerator
  def random_name
    alpha = "#{generate_char}#{generate_char}"
    numeric = "#{generate_num}#{generate_num}#{generate_num}"
    alpha << numeric
  end

  private

  def generate_char
    ('A'..'Z').to_a.sample
  end

  def generate_num
    rand(10)
  end
end
