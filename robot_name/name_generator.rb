require 'securerandom'

class NameGenerator
  def self.call
    generate_name
  end

  private

  # The reason I put this in private is because this type of method should not be accessible to other classes.
  # It's similar to when you have authentication or what not. - svajone
  def self.generate_name
    # I am using SecureRandom here just for kicks and giggles.
    # No really I am using it because it's a good method to generate
    # random instances of a number. -svajone
    numbers = ('0'..'9').to_a
    letters = ('A'..'Z').to_a
    alpha_characters = randomizer(letters)
    numeric_characters = randomizer(numbers)
    name = alpha_characters.sample(2) + numeric_characters.sample(3)
    name.join
  end

  private

  def self.randomizer(characters)
    length = 10
    result = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end
  end
end
