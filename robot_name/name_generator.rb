class NameGenerator
  def random_name
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    alpha = "#{generate_char.call}#{generate_char.call}"
    numeric = "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
    alpha + numeric
  end
end
