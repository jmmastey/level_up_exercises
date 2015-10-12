class DefaultNameGenerator
  def alpha_gen
    ('A'..'Z').to_a.sample
  end

  def digit_gen
    rand(10)
  end

  def call
    new_name = ""
    2.times { new_name.concat(alpha_gen) }
    3.times { new_name.concat(digit_gen.to_s) }
    new_name
  end
end
