class Trigger
  def initialize
    @active = false
  end

  def activate(code)
    @active = true if valid?(code)
  end

  def deactivate(code)
    @active = false if valid?(code)
  end

  def activated?
    @active
  end

  def deactivated?
    !activated?
  end

  private

  def valid?(code)
    code =~ /(^\d{4}$)/
  end
end
