require "set"
require_relative "errors.rb"

class RobotRegistry
  def initialize(args = {})
    @registry = args[:registry] || Set.new
  end

  def add(name)
    raise NameCollisionError,
      "#{name} is already in the registry!" if @registry.include?(name)

    @registry << name
  end

  alias_method :<<, :add
end
