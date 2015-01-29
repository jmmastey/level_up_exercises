module BombHelpers
  def self.explode_bomb(bomb)
    return if bomb.nil?
    bomb.explode! if self.time_to_explode? bomb
  end

  private

  def self.time_to_explode?(bomb)
    !(bomb.activated_time.nil?) &&
      (Time.now >= bomb.activated_time + bomb.detonation_time.seconds) &&
      (bomb.active?)
  end
end
