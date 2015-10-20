class DefaultRobotNameGenerator

  RANDOM_CHAR = proc { [*'A'..'Z'].sample }
  RANDOM_NUM = proc { rand(10) }

  RANDOM_NAME = proc { "#{RANDOM_NUM}#{RANDOM_NUM}#{RANDOM_CHAR}#{RANDOM_CHAR}#{RANDOM_CHAR}" }

  private_constant :RANDOM_CHAR, :RANDOM_NUM

end