module BombHelpers
  def self.explode_bomb(bomb)
    return if bomb.nil?
    if self.time_to_explode? bomb
      bomb.explode!
    end
  end

  private

  def self.time_to_explode?(bomb)
    !(bomb.activated_time.nil?) &&
      (Time.now >= bomb.activated_time + bomb.detonation_time.seconds)
  end
end
