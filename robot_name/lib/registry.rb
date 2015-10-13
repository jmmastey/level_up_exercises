class Registry
  class GarbageError < RuntimeError; end
  class CollisionError < RuntimeError; end
  class PatternError < RuntimeError; end

  attr_reader :registry

  FORMAT_REGEXP = /[[:alpha:]]{2}[[:digit:]]{3}/

  def initialize
    @registry = []
  end

  def add_entry(new_entry)
    validate_entry(new_entry)
    @registry.push(new_entry)
  end

private
  def test_garbage_name(new_entry)
    raise GarbageError, "Junk Name Error" if new_entry == '' || new_entry.nil?
  end

  def test_pattern_name(new_entry)
    raise PatternError, "Pattern Mismatch" unless new_entry =~ FORMAT_REGEXP
  end

  def test_redundancy(new_entry)
    raise CollisionError, "Already in Registry" if @registry.include?(new_entry)
  end

  def validate_entry(new_entry)
    test_garbage_name(new_entry)
    test_pattern_name(new_entry)
    test_redundancy(new_entry)
  end
end
