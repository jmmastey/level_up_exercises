require "token_selectable"

# Ambulation
#
# Class handling and representing dinosaur locomotion (bi/quradrupedalism).
module Dinodex
  class Ambulation < TokenSelectable
    alias_method :ambulation, :name     # (string) descriptive noun

    @all_instances = [
      BIPEDAL       = new("bipedal", /biped/i),
      QUADRUPEDAL   = new("quadrupedal", /quadr/i),
    ]
  end
end
