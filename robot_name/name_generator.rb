require 'securerandom'

class NameGenerator
  def self.call
    generate_name
  end

  private

  # The reason I put this in private is because this type of method
  # should not be accessible to other classes.
  # It's similar to when you have authentication or what not. - svajone
  def self.generate_name
    # I am using SecureRandom here just for kicks and giggles.
    # No really I am using it because it's a good method to generate
    # random instances of a number. -svajone
    numbers = ('0'..'9').to_a
    letters = ('A'..'Z').to_a
    alpha_characters = randomize(letters)
    numeric_characters = randomize(numbers)
    name = alpha_characters.sample(2) + numeric_characters.sample(3)
    name.join
  end

  private_class_method

  def self.randomize(characters)
    SecureRandom.random_bytes(characters.length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end
  end
end
