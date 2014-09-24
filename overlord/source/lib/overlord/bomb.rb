require 'digest'

module Overlord
  class ExplosiveError < RuntimeError
    def to_s
      "BOOM! You're dead!"
    end
  end

  class ValidationError < TypeError
    def to_s
      'Input must be numeric!'
    end
  end

  class Bomb
    attr_reader :attempts, :status, :time
    ACTIVATION_CODE, DEACTIVATION_CODE = '1234', '0000'

    singleton_class.send(:alias_method, :boot!, :new)

    def initialize(activation_code = nil)
      reset_configuration
      activation_code ||= ACTIVATION_CODE
      @activation_code = self.class.digest_code(activation_code)
    end

    def active?
      @status == :activated
    end

    def activate!(activation_code, deactivation_code = nil)
      return unless authenticate(activation_code)
      deactivation_code ||= DEACTIVATION_CODE
      @deactivation_code = self.class.digest_code(deactivation_code)
      @attempts, @time, @status = 0, Time.now, :activated
    end

    def inactive?
      !active?
    end

    # rubocop:disable Style/GuardClause
    def deactivate!(code)
      if active?
        reset_configuration if authenticate(code)
        boom! if failed_attempt > 2 && active?
      end
    end
    # rubocop:enable Style/GuardClause

    def reboot!(activation_code = nil)
      return boom! if active?
      initialize(activation_code)
    end

    def boom!
      @status = :exploded
      raise(ExplosiveError)
    end

    private

    def authenticate(code)
      target = active? ? @deactivation_code : @activation_code
      target == self.class.digest_code(code)
    end

    def failed_attempt
      @attempts += 1
    end

    def reset_configuration
      @activation_code, @deactivation_code = nil, nil
      @attempts, @time, @status = 0, nil, :deactivated
    end

    def self.digest_code(code)
      raise(ValidationError) unless code.to_s =~ (/^[0-9]+$/)
      Digest::SHA512.digest(code.to_s)
    end
  end
end
