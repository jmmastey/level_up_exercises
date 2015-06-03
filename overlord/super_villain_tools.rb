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
    # FIXME: weird hack. may need to fix
    # int.to_i.to_s != int.to_s for "0000"
    init_len = input.length
    input_int = input.to_i
    input_str = input_int.to_s
    new_len = input_str.length

    # new_input_str = "0" * (init_len - new_len) + input_str

    new_input_str == input.to_s
  end

  def valid_bomb_options?(options)
    return true if options.empty?

    activation_code = options[:activation_code]
    deactivation_code = options[:deactivation_code]

    (activation_code.nil? || number?(activation_code)) &&
      (deactivation_code.nil? || number?(deactivation_code))
  end
end
