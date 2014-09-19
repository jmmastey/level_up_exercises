class Bomb
  attr_reader :devices
  def initialize(devices)
    @devices = devices
    raise_bad_devices_error unless all_devices_respond_to_triggered?
  end

  def exploded?
    @devices.each_value do |device|
      return true if device.triggered?
    end
    false
  end

  private

  def raise_bad_devices_error
    raise(RuntimeError, "all devices must respond to triggered?")
  end

  def all_devices_respond_to_triggered?
    @devices.each_value do |device|
      return false unless device.respond_to?(:triggered?)
    end
    true
  end
end
