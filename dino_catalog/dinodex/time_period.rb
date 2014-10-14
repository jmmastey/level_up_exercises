# Objects that represent a major interval in evolutionary/geological history. Because this is a fixed list
# it can be represented as such in software.
class Dinodex::TimePeriod
  attr_reader :period

  def initialize(period)
    @period = period
  end

  # These terms are given meaning in the field of paleontology.
  OXFORDIAN         = new("Oxfordian")
  PERMIAN           = new("Permian")
  ALBIAN            = new("Albian")
  TRIASSIC          = new("Triassic")
  JURASSIC          = new("Jurassic")
  CRETACEOUS        = new("Cretaceous")

  def self.decode(word)
    case word
    when /oxf/i then OXFORDIAN
    when /perm/i then PERMIAN
    when /alb/i then ALBIAN
    when /tri/i then TRIASSIC
    when /jur/i then JURASSIC
    when /cret/i then CRETACEOUS
    else nil
    end
  end
end 
