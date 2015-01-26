module Overlord
  class Bomb
    attr_reader :status, :errors

    def initialize
      @status = "Setup"
      @errors = []
      @failed_deactivations = 0
    end

    def setup(activation_code, deactivation_code)
      @errors = []
      validate_activation_code(activation_code)
      validate_deactivation_code(deactivation_code)
      return unless @errors.empty?

      @activation_code = activation_code.empty? ? "1234" : activation_code
      @deactivation_code = deactivation_code.empty? ? "0000" : deactivation_code
      @status = "Ready"
    end

    def activate(code)
      @errors = []
      if code == @activation_code
        @status = "Activated"
      else
        @errors << "Invalid Activation Code"
      end
    end

    def deactivate(code)
      @errors = []
      if code == @deactivation_code
        @status = "Ready"
      else
        @errors << "Invalid Deactivation Code"
        fail_deactivation
      end
    end

    private

    def validate_activation_code(code)
      @errors << "Invalid Activation Code" unless valid_code?(code)
    end

    def validate_deactivation_code(code)
      @errors << "Invalid Deactivation Code" unless valid_code?(code)
    end

    def valid_code?(code)
      code !~ /\D/
    end

    def fail_deactivation
      @failed_deactivations += 1
      @status = "BOOM" if @failed_deactivations == 3
    end
  end
end
