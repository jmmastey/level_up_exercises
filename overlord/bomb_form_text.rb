class BombFormText
  def self.code_message(bomb)
    if bomb.detonated?
      "You are dead"
    elsif bomb.active?
      "Enter deactivation code:"
    else
      "Enter activation code:"
    end
  end

  def self.status_message(bomb)
    if bomb.detonated?
      "Bomb has been detonated!"
    elsif bomb.active?
      "Warning: Bomb is active!"
    else
      "The bomb is not active"
    end
  end

  def self.disabled(bomb)
    bomb.detonated? ? "disabled" : ""
  end
end
