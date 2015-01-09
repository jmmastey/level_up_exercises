require_relative 'bomb'

class BombSession
  def self.started?
    session.inspect
    true
    #Bomb.instance_methods.any? { |name| session.has_key?(name) }
  end

  def self.bomb_to_session(bomb)
    bomb.instance_variables.each { |name| update_session(name) }
  end

  def self.update_session_variable(name)
    session_variable = instance_var_to_symbol(name)
    session[session_variable] = instance_variable_get(name)
  end

  def self.session_to_bomb
    Bomb.new(session)
  end

  def self.instance_var_to_symbol(var)
    var.to_s.sub("@", ":")
  end

  def self.get_bomb_instance
    if started?
      puts "get_bomb_instance"
      Bomb.new
      # session_to_bomb
    else
      @bomb = Bomb.new
      bomb_to_session(@bomb)
      @bomb
    end
  end
end