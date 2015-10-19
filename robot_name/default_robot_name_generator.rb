class DefaultRobotNameGenerator < Proc

  def self.new
    super() do
      "#{random_char}#{random_char}#{random_num}#{random_num}#{random_num}"
    end
  end

  class << self
    def random_char
      [*'A'..'Z'].sample
    end

    def random_num
      rand(10)
    end
  end

  private_class_method :random_char, :random_num

  self

end
