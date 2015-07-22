class BadComponentError < StandardError
  def message
    'Bomb components must respond to detonated messages.'
  end
end

class Bomb
  attr_reader :components

  def initialize(components)
    @components = components
    verify_working_components
  end

  def detonated?
    @components.each_value do |component|
      return true if component.detonated?
    end
    false
  end

  private

  def verify_working_components
    components.each_value do |component|
      raise BadComponentError unless component.respond_to?(:detonated?)
    end
  end
end
