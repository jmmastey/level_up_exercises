class Bomb
  attr_reader :id, :activation_code

  def initialize(args)
    @activation_code = args[:create_activation_code]
  end

end