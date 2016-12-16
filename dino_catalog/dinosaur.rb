class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :walking,
              :description, :size, :to_h

  def initialize(args = {})
    @to_h = args
    args.each { |k,v| instance_variable_set("@#{k}", v) }
  end

  def to_s
    Array(to_h).reject { |pair|
      pair.include?(nil) }.map { |pair|
        pair.join(": ") }.join("\n")
  end
end
