require_relative 'robot_registry'
require_relative 'robot_errors'

class NameGenerator
  # this should be the only class that cares about the registry

  REGISTRY = RobotRegistry.new
  ROBOT_NAME_FORMAT = /^[[:alpha:]]{2}[[:digit:]]{3}$/
  VALID_LETTERS = ('A'..'Z').to_a
  VALID_NUMBERS = (1..9).to_a

  def robot_name
    generate_unique_name
  end

  private

  def random_letter_sequence(number_of_characters)
    number_of_characters.times.inject('') do |sequence, _iteration|
      sequence << VALID_LETTERS.sample
    end
  end

  def random_number_sequence(number_of_digits)
    number_of_digits.times.inject('') do |sequence, _iteration|
      sequence << VALID_NUMBERS.sample.to_s
    end
  end

  def generate_name
    "#{random_letter_sequence(2)}#{random_number_sequence(3)}".tap do |name|
      check_name_format(name)
    end
  end

  def register_name(name)
    if !REGISTRY.contains?(name)
      REGISTRY.add_name(name)
    else
      raise NameRegistryError, "#{name} is already in the registry."
    end
  end

  def generate_unique_name(max_attempts = 10)
    attempts = 0
    while attempts < max_attempts
      begin
        attempts += 1
        name = generate_name
        register_name(name)
        return name
      rescue NameRegistryError
        next
      end
    end

    raise NameRegistryError, "Name cannot be generated. (#{attempts} attempts)"
  end

  def check_name_format(name)
    unless name =~ ROBOT_NAME_FORMAT
      raise NameFormatError, "The robot's name sucks! (#{name})"
    end
  end

end