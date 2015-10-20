class DefaultRobotNameGenerator

  CHARACTER_ARRAY = [*'A'..'Z']

  private_constant :CHARACTER_ARRAY

  def call
    "#{random_char}#{random_char}#{random_num}#{random_num}#{random_num}"
  end

  private
  def random_char
    CHARACTER_ARRAY.sample
  end

  def random_num
    rand(10)
  end

end