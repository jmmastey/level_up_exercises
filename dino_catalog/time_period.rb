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
end 
