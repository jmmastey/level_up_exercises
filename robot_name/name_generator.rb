require 'securerandom'

class NameGenerator
  def self.call(options = {})
    length = options[:length] || nil
    self.generate_name(length)
  end

  private
  # The reason I put this in private is because this type of method should not be accessible to other classes.
  # It's similar to when you have authentication or what not. - svajone
  def self.generate_name(length)
    # I am using SecureRandom here just for kicks and giggles.
    # No really I am using it because it's a good method to generate
    # random instances of a number. -svajone
    length  = 5 if length.nil?
    characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
    name = SecureRandom.random_bytes(length).each_char.map do |char|
      characters[(char.ord % characters.length)]
    end.join
  end
end
