# Class providing class-level factory capability to fetch an instance based on
# input tokens
#
# By default subclass must define:
# - @all_instances (class inst var) to be a list of predefined instances
# - @token_pattern to be a RegExp an instance uses to match token
#
class TokenSelectable
  attr_reader :name

  def initialize(instance_name, token_pattern)
    @name, @token_pattern = instance_name, token_pattern
  end

  def recognizes_token?(token)
    @token_pattern.match(token)
  end

  def to_s
    name
  end

  def self.decode_instance_token(token)
    @all_instances.find { |inst| inst.recognizes_token?(token) }
  end
end
