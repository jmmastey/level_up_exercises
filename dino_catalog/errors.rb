class CommandException < StandardError
  attr_accessor :continue

  def initialize(args)
    @continue = args[:continue]
  end
end
