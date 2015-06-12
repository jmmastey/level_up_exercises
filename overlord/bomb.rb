class BootError < RuntimeError; end

class Bomb
  attr_accessor :status
  attr_reader :activation_code, :deactivation_code, :booted
  alias_method :booted?, :booted

  def initialize()
    @status = default_status
    @booted = false
  end

  def boot(args={})
    raise BootError if booted?
    @activation_code = args.fetch(:activation_code, default_activation_code)
    @deactivation_code = args.fetch(:deactivation_code, default_deactivation_code)
    @booted = true
    @status = "Inactive"
  end

  def apply_code(code)
    @status = "Active" if @status == "Inactive"
    @status = "Inactive" if @status == "Active"
  end

  def default_status
    "Offline"
  end

  def default_activation_code
    1234
  end

  def default_deactivation_code
    "0000"
  end
end
