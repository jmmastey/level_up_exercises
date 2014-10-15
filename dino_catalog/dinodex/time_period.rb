# Objects that represent a major interval in evolutionary/geological history.
# Because this is a fixed list it can be represented as such in software.
module Dinodex
  class TimePeriod < TokenSelectable
    alias_method :period, :name       # Geological time period

    # These terms are given meaning in the field of paleontology.
    @all_instances = [
      OXFORDIAN         = new("Oxfordian", /oxf/i),
      PERMIAN           = new("Permian", /perm/i),
      ALBIAN            = new("Albian", /alb/i),
      TRIASSIC          = new("Triassic", /tri/i),
      JURASSIC          = new("Jurassic", /jur/i),
      CRETACEOUS        = new("Cretaceous", /cre/i),
    ]
  end
end
