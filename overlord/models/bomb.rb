class Bomb
  attr_accessor :status
  attr_reader :activate_code, :deactivate_code, :attempts

  def initialize(activate_code: '1234', deactivate_code: '0000')
    @activate_code = check_code?(activate_code)
    @deactivate_code = check_code?(deactivate_code)
    @status = 'inactive'
    @attempts = 0
  end

  def activate(act_user)
    if @activate_code.eql?(act_user) && @status.eql?('inactive')
      @status = 'active'
    else
      @status
    end
  end

  def deactivate(dact_user)
    @attempts += 1
    explode if @attempts >=  3
    @status = 'inactive' if @deactivate_code.eql?(dact_user)
  end

  def explode
    return @status unless @status.eql?('active')
    @status, @activate_code, @deactivate_code = 'explode', 'explode', 'explode'
  end

  def valid_code?(pin)
    /^\d{4}$/ === pin
  end

  def check_code?(pin)
    return pin if valid_code?(pin) == true
    return 'invalid' if valid_code?(pin) == false
  end

  def to_s
    "#{@activate_code} #{@deactivate_code} #{@status}"
  end
end
