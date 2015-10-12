class DefaultNameGenerator
  def call
    generate_char = -> { ('A'..'Z').to_a.sample }
    generate_num = -> { rand(10) }

    # pattern AB123
    "#{generate_char.call}#{generate_char.call}"\
    "#{generate_num.call}#{generate_num.call}#{generate_num.call}"
  end
end
