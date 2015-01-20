module BombHelpers
  def self.active?(bomb)
    bomb.status == "active"
  end

  def self.bomb_status(bomb)
    return { bomb_status: nil }.to_json if bomb.nil?
    if self.bomb_exploded? bomb
      bomb.status = :explode
      bomb.save!
    end

    { bomb_status: bomb.status, detonation_time: bomb.detonation_time,
      wires: bomb.wires }.to_json
  end

  def self.bomb_exploded?(bomb)
    !(bomb.activated_time.nil?) &&
      (Time.now >= bomb.activated_time + bomb.detonation_time.seconds)
  end

  def self.match_activation_code?(bomb, code)
    bomb.activation_code == code["activation_code"] &&
      !BombHelpers.active?(bomb)
  end

  def self.match_deactivation_code?(bomb, code)
    bomb.deactivation_code == code["deactivation_code"] &&
      BombHelpers.active?(bomb)
  end
end
