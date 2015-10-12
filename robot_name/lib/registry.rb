require './lib/pattern_error'
require './lib/name_collision_error'
require './lib/garbage_error'

class Registry
  attr_reader :registry

  def initialize
    @registry = []
  end

  def add_entry(new_entry)
    validate_entry(new_entry)
    @registry.push(new_entry)
  end

  def test_garbage_name(new_entry)
    raise GarbageError, "Garbage Name Error" if new_entry == '' || new_entry.nil?
  end

  def test_pattern_name(new_entry)
    raise PatternError, "Pattern Mismatch" unless new_entry =~ /[[:alpha:]]{2}[[:digit:]]{3}/
  end

  def test_redundancy(new_entry)
    raise NameCollisionError, "Name Already in Registry" if @registry.include?(new_entry)
  end

  def validate_entry(new_entry)
    test_garbage_name(new_entry)
    test_pattern_name(new_entry)
    test_redundancy(new_entry)
  end
end
