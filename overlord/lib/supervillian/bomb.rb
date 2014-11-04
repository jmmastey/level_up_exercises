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

    attr_reader :arming_code, :disarming_code, :delay, :armed, :locked

    def initialize(arming_code = DEFAULT_ARMING_CODE,
                   disarming_code = DEFAULT_DISARMING_CODE,
                   delay = DEFAULT_DELAY)
      @arming_code, @disarming_code, @delay = arming_code, disarming_code, delay
      @explode_timer, @started_countdownm, @mutex = nil, 0, Mutex.new
      @locked = @armed = @exploded = false
    end

    def lock!
      check_exploded
      @locked = true
    end

    def arming_code=(code)
      check_if_able_to_set_activation_code(code)
      @arming_code = code
    end

    def disarming_code=(code)
      check_if_able_to_set_activation_code(code)
      @disarming_code = code
    end

    def delay=(delay)
      check_exploded
      raise_error(OperationDeniedError) if armed
      @delay = delay
    end

    def delay_remaining
      armed ? (delay - Time.now.to_i + @started_countdown) : delay
    end

    def arm!(code)
      check_exploded
      raise_error(InvalidBombStateError) unless locked && !armed
      raise_error(WrongActivationCodeError) unless code == arming_code
      @disarm_retry_count = 0
      do_arm
    end

    def disarm!(code)
      disarm(code)
    rescue WrongActivationCodeError
      explode_early if (@disarm_retry_count == 2)
      @disarm_retry_count += 1
      raise
    end

    def exploded?
      @mutex.synchronize { @exploded }
    end

    private

    def check_if_able_to_set_activation_code(code)
      check_exploded
      raise_error(OperationDeniedError) if locked || armed
      raise_error(WrongActivationCodeError,
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
      check_exploded
      raise_error(WrongActivationCodeError) unless code == disarming_code
      cancel_explode_timer
      @armed = false
    end

    def explode_early
      cancel_explode_timer
      explode
    end

    def explode
      @mutex.synchronize do
        @exploded = true
        @armed = false
      end
    end

    def check_exploded
      raise_error(ExplodedError) if exploded?
    end

    def cancel_explode_timer
      @mutex.synchronize do
        return unless @explode_timer
        @explode_timer.kill
        @explode_timer = nil
      end
    end

    ERROR_MESSAGES = {
      InvalidStateError => 'Operation not possible',
      OperationDeniedError => "Operation not permitted",
      ExplodedError => "This bomb has already exploded",
      WrongActivationCodeError => "Invalid activation code",
    }

    def raise_error(type, message = ERROR_MESSAGES[type])
      raise type, message
    end
  end
end
