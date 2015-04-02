class NameGenerator
  # this should be the only class that cares about the registery
  require_relative 'robot_registry'
  require_relative 'robot_errors'

  REGISTRY = RobotRegistry.new
  ROBOT_NAME_FORMAT = /^[[:alpha:]]{2}[[:digit:]]{3}$/
  UNIQUE_NAME_MAX_ATTEMPTS = 10
  VALID_LETTERS = ('A'..'Z').to_a
  VALID_NUMBERS = (1..9).to_a

  def self.robot_name
    generate_unique_name(UNIQUE_NAME_MAX_ATTEMPTS).tap do |name|
      check_name_format(name)
      REGISTRY.add_name(name)
    end
  end

  private
  def self.random_letter_sequence(number_of_characters)
    number_of_characters.times.inject('') { |string, _iteration|
      string << VALID_LETTERS.sample
    }
  end

  private
  def self.random_number_sequence(number_of_digits)
    number_of_digits.times.inject('') { |int, _iteration|
      int << VALID_NUMBERS.sample.to_s
    }
  end

  private
  def self.generate_name
    "#{random_letter_sequence(2)}#{random_number_sequence(3)}"
    # IB "Magic numbers." Cost of changing later is identical to now.
  end

  private
  def self.generate_name_and_register
    name = generate_name
    REGISTRY.add_name(name) ? name : nil # is this weird?
  end

  private
  def self.generate_unique_name(max_attempts)
    attempts = 0

    while attempts < max_attempts
      name = generate_name_and_register
      return name unless name.nil?
      attempts += 1
    end

    raise NameRegistryError, "Unique name cannot be generated."
  end

  private
  def self.check_name_format(name)
    unless name =~ ROBOT_NAME_FORMAT
      raise NameFormatError, "The robot's name sucks! (#{name})"
    end
  end

end