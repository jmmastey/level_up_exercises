# Class providing class-level factory capability to fetch a (possible
# preallocated) instance based on recognizing input tokens
class TokenSelectable
  attr_reader :name

  def initialize(instance_name, token_recognition_pattern)
    @name, @token_recognition_pattern = instance_name, token_recognition_pattern
  end

  def recognizes_token?(token)
    @token_recognition_pattern.match(token)
  end

  def to_s
    name
  end

  def self.token_selectable_instances
    raise NotImplementedError,
          "Subclass lists each instance recognizing a token selecting it"
  end

  def self.decode_instance_token(token)
    token_selectable_instances.find { |inst| inst.recognizes_token?(token) }
  end
end
