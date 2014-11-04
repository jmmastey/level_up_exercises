require "token_selectable"

module DinosaurIndex
  class Posture < TokenSelectable
    alias_method :posture, :name

    POSTURES =
    [
      BIPEDAL       = new("bipedal", /biped/i),
      QUADRUPEDAL   = new("quadrupedal", /quadr/i),
    ]

    def self.token_selectable_instances
      POSTURES
    end
  end
end
