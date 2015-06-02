require_relative 'bomb.rb'
class SuperVillainTools
  attr_accessor :tools
  def initialize
    @tools = {}
  end

  def bomb?
    !bomb.nil?
  end

  def create_bomb(options: {})
    raise "Invalid Code" unless valid_bomb_options?(options)
    add_tool(type: "bomb", options: options)
  end

  def bomb
    @tools[:bomb]
  end

  private

  def add_tool(type: "bomb", options: {})
    if type == "bomb"
      @tools[type.to_sym] = Bomb.new(options)
    else
      @tools[type.to_sym] = type
    end
  end

  def number?(input)
    input.to_i.to_s == input.to_s
  end

  def valid_bomb_options?(options)
    return true if options.empty?

    activation_code = options[:activation_code]
    deactivation_code = options[:deactivation_code]

    (activation_code.nil? || number?(activation_code)) &&
      (deactivation_code.nil? || number?(deactivation_code))
  end
end
