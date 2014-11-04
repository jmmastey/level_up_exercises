module Supervillian

  BombError = Class.new(Exception)
  WrongActivationCodeError = Class.new(BombError)
  OperationDeniedError = Class.new(BombError)
  InvalidStateError = Class.new(BombError)
  ExplodedError = Class.new(InvalidStateError)

  class Bomb
    DEFAULT_ARMING_CODE = "1234"
    DEFAULT_DISARMING_CODE = "0000"
    DEFAULT_DELAY = 10

    attr_reader :arming_code, :disarming_code, :delay, :armed

    def initialize(arming_code = DEFAULT_ARMING_CODE,
                   disarming_code = DEFAULT_DISARMING_CODE,
                   delay = DEFAULT_DELAY)
      @arming_code, @disarming_code, @delay = arming_code, disarming_code, delay
      @locked = @armed = @exploded = false
      @explode_timer, @mutex = nil, Mutex.new
      @started_countdown = 0;
    end
 
    def lock!
      check_exploded
      @locked = true
    end

    def locked?
      @locked
    end

    def armed?
      @armed && !exploded?
    end

    def arming_code=(code)
      can_be_configured?
      validate_activation_code(code)
      @arming_code = code
    end

    def disarming_code=(code)
      can_be_configured?
      validate_activation_code(code)
      @disarming_code = code
    end

    def delay=(delay)
      check_exploded
      raiseError(OperationDeniedError) if armed?
      @delay = delay
    end

    def delay_remaining
      armed? ? (delay - Time.now.to_i + @started_countdown) : delay
    end

    def arm!(code)
      check_exploded
      raiseError(InvalidBombStateError) unless locked? && !armed?
      raiseError(WrongActivationCodeError) unless code == arming_code
      @disarm_retry_count = 0
      do_arm
    end

    def disarm!(code)
      check_exploded
      begin
        disarm(code)
      rescue WrongActivationCodeError
        explode_early if (@disarm_retry_count == 2)
        @disarm_retry_count += 1
        raise
      end
    end

    def exploded?
     @mutex.synchronize { @exploded }
    end

    private

    def validate_activation_code(code)
      raiseError(WrongActivationCodeError,
                 "Activation code must be numeric") unless code =~ /^\d+$/
    end

    def do_arm
      @armed = true
      @started_countdown = Time.now.to_i
      @explode_timer = Thread.new do
        sleep(@delay)
        explode
        @explode_timer = nil
      end
    end

    def disarm(code)
      raiseError(WrongActivationCodeError) unless code == disarming_code
      cancel_explode_timer
      @armed = false
    end

    def explode_early
      cancel_explode_timer
      explode
    end

    def explode
      @mutex.synchronize { @exploded = true }
    end

    def can_be_configured?
      check_exploded
      raiseError(OperationDeniedError) if locked? || armed?
    end

    def check_exploded
      raiseError(ExplodedError) if exploded?
    end

    def cancel_explode_timer
      @mutex.synchronize do
        return unless @explode_timer
        @explode_timer.kill
        @explode_timer = nil
      end
    end

    ERROR_MESSAGES =
    {
      InvalidStateError => 'Operation not possible',
      OperationDeniedError => "Operation not permitted",
      ExplodedError => "This bomb has already exploded",
      WrongActivationCodeError => "Invalid activation code",
    }

    def raiseError(type, message = ERROR_MESSAGES[type])
      raise type, message
    end
  end
end
