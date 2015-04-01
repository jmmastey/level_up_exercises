class NameGenerator
  # this should be the only class that cares about the registery
  require_relative 'robot_registery'
  require_relative 'robot_errors'

  REGISTERY = RobotRegistery.new
  ROBOT_NAME_FORMAT = /[[:alpha:]]{2}[[:digit:]]{3}/
  UNIQUE_NAME_MAX_ATTEMPTS = 10

  def self.generate_char
    ('A'..'Z').to_a.sample 
  end

  def self.generate_num
    rand(10)
  end

  def self.generate_name
    name = "#{generate_char}#{generate_char}"+ 
    "#{generate_num}#{generate_num}#{generate_num}"
  end

  def self.generate_unique_name(max_attempts)
    name = generate_name
    attempts = 0

    while REGISTERY.contains? name
      name = generate_name
      attempts += 1
      raise NameRegistryError, 
        "Unique name cannot be generated." if attempts == max_attempts
    end

    name
  end

  def self.check_name_format(name)
    unless name =~ ROBOT_NAME_FORMAT
      raise NameFormatError, "The robot's name sucks! (#{name})"
    end
  end

  def self.call
    name = generate_unique_name(UNIQUE_NAME_MAX_ATTEMPTS)
    check_name_format(name)
    REGISTERY.add_name(name)  
    name
  end
end
