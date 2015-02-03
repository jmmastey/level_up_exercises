module BombHelpers
  def self.explode_bomb(bomb)
    return if bomb.nil?
    bomb.explode! if self.time_to_explode? bomb
  end

  private

  def self.time_to_explode?(bomb)
      self.is_bomb_active?(bomb) &&
      (Time.now >= bomb.activated_time + bomb.detonation_time.seconds)

  end

  def self.is_bomb_active?(bomb)
    !(bomb.activated_time.nil?) && (bomb.active?)
  end
end
