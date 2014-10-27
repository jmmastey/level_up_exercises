# Objects that represent a major interval in evolutionary/geological history.
# Because this is a fixed list it can be represented as such in software.
module Dinodex
  class TimePeriod < TokenSelectable
    attr_accessor :qualifier    # late, early, ....

    alias_method :period, :name       # Geological time period

    def initialize(period, pattern, qualifier = nil)
      super(period, pattern)
      @qualifier = qualifier
    end

    def to_s
      period + (qualifier ? " (#{qualifier})" : '')
    end

    # Ignores qualifier, just matches period itself
    def ==(other)
      period == other.period
    end

    class << self
      alias_method :decode_token_to_prototype, :decode_instance_token

      # Overridden to select, clone, and configure prototype
      def decode_instance_token(token)
        matches = /(?:(\w+)\s+)?(\w+)/.match(token || '')
        qualifier, period = matches[1, 2]
        period && find_and_clone_prototype(period, qualifier)
      end
    end

    OXFORDIAN  = "Oxfordian"
    PERMIAN    = "Permian"
    ALBIAN     = "Albian"
    TRIASSIC   = "Triassic"
    JURASSIC   = "Jurassic"
    CRETACEOUS = "Cretaceous"

    # This are PROTOTYPES, cloned to make custom instances
    @all_instances = [
      new(OXFORDIAN, /oxf/i),
      new(PERMIAN, /perm/i),
      new(ALBIAN, /alb/i),
      new(TRIASSIC, /tri/i),
      new(JURASSIC, /jur/i),
      new(CRETACEOUS, /cre/i),
    ]

    def self.find_and_clone_prototype(period_token, qualifier)
      (prototype = decode_token_to_prototype(period_token)) && begin
        new_instance = prototype.clone
        new_instance.qualifier = qualifier
        new_instance
      end
    end
  end
end
