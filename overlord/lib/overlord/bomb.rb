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
      if activation_code.empty?
        activation_code = "1234"
      elsif activation_code =~ /\D/
        @errors << "Invalid Activation Code"
      end
      if deactivation_code.empty?
        deactivation_code = "0000"
      elsif deactivation_code =~ /\D/
        @errors << "Invalid Deactivation Code"
      end
      return if !@errors.empty?
      @activation_code = activation_code
      @deactivation_code = deactivation_code
      @status = "Ready"
    end

    def activate(code)
      @errors = []
      if code == @activation_code
        @status = "Activated"
      else
        @errors = ["Invalid Activation Code"]
      end
    end

    def deactivate(code)
      @errors = []
      if code == @deactivation_code
        @status = "Ready"
      else
        @failed_deactivations += 1
        if @failed_deactivations == 3
          @status = "BOOM"
        else
          @errors << "Invalid Deactivation Code"
        end
      end
    end
  end
end
