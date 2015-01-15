class Overlord::Bomb
  def initialize
    @state             = 'deactived'
    @activation_code   = '1234'
    @deactivation_code = '0000'
  end

  def active?
    @state == 'active'
  end


  def process_code(code='')
    if @state == 'deactived' && code == @activation_code
      activate(code)
    elsif @state == 'active' && code == @deactivation_code
      deactivate(code)
    end
  end

  private

  def activate(code)
    return if @state == 'active'

    @state = 'active'
  end

  def deactivate(code)
    return if @state == 'deactive'

    @state = 'deactivated'
  end
end
