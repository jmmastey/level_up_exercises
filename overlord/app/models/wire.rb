# File wire.rb

class Wire
  include DataMapper::Resource

  property :id, Serial
  property :color, String, required: true
  property :detonates, Boolean, default: false
  property :speeds_up, Boolean, default: false
  property :speeds_down, Boolean, default: false
  property :diffuses, Boolean, default: false

  belongs_to :bomb

  def inert?
    !(@detonates && @speeds_down && @speeds_up && @diffuses)
  end
end
