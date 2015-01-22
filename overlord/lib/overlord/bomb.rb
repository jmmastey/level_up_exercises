class Overlord::Bomb
  def initialize(opts = {})
    @state                       = 'deactivated'
    @activation_code             = '1234'
    @deactivation_code           = '0000'
    @exploded                    = false
    @bad_deactivation_code_count = 0

    if opts && opts.size > 0
      initialize_from_session(opts)
    end
  end

  def active?
    @state == 'activated'
  end

  def error
    @error
  end

  def exploded?
    @state == 'exploded'
  end

  def initialize_session
    {
      :activation_code             => @activation_code,
      :bad_deactivation_code_count => @bad_deactivation_code_count,
      :deactivation_code           => @deactivation_code,
      :state                       => @state
    }
  end

  def process_code(code='')
    if @state == 'deactivated'
      activate(code)
    elsif @state == 'activated'
      deactivate(code)
    end
  end

  def update_activation_code(activation_code)
    return if @state == 'exploded'

    if valid_code?(activation_code)
      @activation_code = activation_code
      true
    else
      false
    end
  end

  def update_deactivation_code(deactivation_code)
    return if @state == 'exploded'

    if valid_code?(deactivation_code)
      @deactivation_code = deactivation_code
      true
    else
      false
    end
  end

  private

  def activate(code)
    return if @state == 'exploded'

    if code == @activation_code
      @state = 'activated'
    else
      @error = "Oops! That was an invalid activation code."
    end
  end

  def deactivate(code)
    return if @state == 'exploded'

    if code == @deactivation_code
      @bad_deactivation_code_count = 0
      @state = 'deactivated'
    else
      @bad_deactivation_code_count += 1
      @error = "Oops! That was an invalid deactivation code."
    end

    if @bad_deactivation_code_count > 2
      @state = 'exploded'
    end
  end

  def initialize_from_session(opts)
    if opts[:state]
      @state = opts[:state]
    end

    if opts[:activation_code]
      @activation_code = opts[:activation_code]
    end

    if opts[:deactivation_code]
      @deactivation_code = opts[:deactivation_code]
    end

    if opts[:bad_deactivation_code_count]
      @bad_deactivation_code_count = opts[:bad_deactivation_code_count]
    end
  end

  def valid_code?(code)
    code =~ /^\d+$/
  end
end
