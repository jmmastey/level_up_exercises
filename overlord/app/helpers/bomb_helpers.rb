module BombHelpers
  def self.is_active?(bomb)
    bomb.status == "active"
  end

  def self.bomb_status(bomb)
    if self.bomb_exploded? bomb
      bomb.status = :explode
    end
    {bomb_status: bomb.status, detonation_time: bomb.detonation_time }.to_json
  end

  def self.bomb_exploded?(bomb)
    !(bomb.activated_time.nil?) && (Time.now >= bomb.activated_time + bomb.detonation_time.seconds)
  end
end