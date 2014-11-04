module DinosaurIndex
  class TimePeriod < TokenSelectable
    attr_accessor :qualifier

    alias_method :period, :name

    def initialize(period, pattern, qualifier = nil)
      super(period, pattern)
      @qualifier = qualifier
    end

    def to_s
      period + (qualifier ? " (#{qualifier})" : '')
    end

    def ==(other)
      period == other.period
    end

    class << self
      alias_method :decode_token_to_prototype, :decode_instance_token

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
    PERIODS =
    [
      new(OXFORDIAN, /oxf/i),
      new(PERMIAN, /perm/i),
      new(ALBIAN, /alb/i),
      new(TRIASSIC, /tri/i),
      new(JURASSIC, /jur/i),
      new(CRETACEOUS, /cre/i),
    ]

    def self.token_selectable_instances
      PERIODS
    end

    def self.find_and_clone_prototype(period_token, qualifier)
      (prototype = decode_token_to_prototype(period_token)) && begin
        new_instance = prototype.clone
        new_instance.qualifier = qualifier
        new_instance
      end
    end
  end
end
