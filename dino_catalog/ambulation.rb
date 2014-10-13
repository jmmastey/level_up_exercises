# Ambulation
#
# Class handling and representing dinosaur locomotion (bi/quradrupedalism).
class Dinodex::Ambulation

  attr_reader :ambulation     # (string) descriptive noun

  def initialize(ambulation_mode)
    @ambulation = ambulation_mode
  end

    BIPEDAL       = new("bipedal"),
    QUADRUPEDAL   = new("quadrupedal")
end
