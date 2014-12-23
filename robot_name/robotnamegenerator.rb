class RobotNameGenerator
  def self.generator
    -> { "#{generate_chars(2)}#{generate_nums(3)}" }
  end

  def self.generate_chars(n = 1)
    n.times.inject("") { |chars| chars + ('A'..'Z').to_a.sample }
  end

  def self.generate_nums(n = 1)
    n.times.inject("") { |nums| nums + rand(10).to_s }
  end
end
