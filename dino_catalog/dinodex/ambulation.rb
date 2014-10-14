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

  def self.decode(word)
    case word
    when /biped/i then BIPEDAL
    when /quadrup/i then QUADRUPEDAL
    else nil
    end
  end
end
