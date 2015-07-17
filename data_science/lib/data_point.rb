class DataPoint
  attr_reader :contents

  def initialize(hash)
    @contents = hash
  end

  def value(measure)
    contents.fetch(measure, nil)
  end

  def match?(requirements_hash)
    requirements_hash.each do |key, value|
      return false unless @contents.key?(key)
      return false unless @contents[key] == value
    end
    true
  end

  def eql?(other)
    @contents == other.contents
  end
end
