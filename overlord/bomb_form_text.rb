class BombFormText
  def self.activate_type(bomb)
    bomb.active? ? "deactivat" : "activat"
  end

  def self.active_warning(bomb)
    bomb.active? ? "Warning: Bomb is active!" : ""
  end
end