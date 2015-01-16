class Overlord::Bomb
  def initialize(opts = {})
    @state             = 'deactivated'
    @activation_code   = '1234'
    @deactivation_code = '0000'

    if opts && opts.size > 0
      initialize_from_session(opts)
    end
  end

  def active?
    @state == 'activated'
  end

  def initialize_session
    {
      :state             => @state,
      :activation_code   => @activation_code,
      :deactivation_code => @deactivation_code
    }
  end

  def process_code(code='')
    if @state == 'deactivated' && code == @activation_code
      activate(code)
    elsif @state == 'activated' && code == @deactivation_code
      deactivate(code)
    end
  end

  def update_activation_code(activation_code)
    @activation_code = activation_code
  end

  def update_deactivation_code(deactivation_code)
    @deactivation_code = deactivation_code
  end

  private

  def activate(code)
    return if @state == 'activated'

    @state = 'activated'
  end

  def deactivate(code)
    return if @state == 'deactivated'

    @state = 'deactivated'
  end

  def initialize_from_session(opts)
    if opts[:state]
      @state = opts[:state]
    end

    if opts[:activation_code]
      @activation_code = opts[:activation_code]
    end
  end
end
