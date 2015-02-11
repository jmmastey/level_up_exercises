require 'virtus'
require 'active_model'
require './models/bombs.rb'

ValidationError = Class.new RuntimeError

class Interface
  include Virtus.model
  include ActiveModel::Validations

  attribute :boot_code, Integer, :default => 6969, :writer => :private # Because Svajone likes. :D
  attribute :deactivation_code, Integer, :default => 6969, :writer => :private # Because Svajone likes. :D

  validates :disarming_code, :presence => true,
            :if => Proc.new { |interface| interface.payload.state == 'activated' }

  attr_reader :payload

  def initialize
    # super is necessary to load default love values.
    # seriously, needed to load the default values being assigned
    # by virtus gem.
    super
    @payload = get_payload
  end

  def configure_settings(options = {})
    # Set the activation code, deactivation code, etc
    unless options.nil?
      opts = options.reject { |key, value| value.nil? }
      # I tried using merge here and merge! and it won't update
      # the attributes so instead I used this approach.
      # If you know of a better way, please comment.
      opts.each do |key, value|
        @payload.send("#{key}=", value)
      end
      validate!
    end
  end

  def turn_on(code)
    # When activating a bomb, event: activate
    @payload.activate if valid_boot_code?(code)
  end

  def deploy
    # When arming a bomb, event: arm
    # A disarming code must be set, if not it will not arm
    # the bomb.
    @payload.arm if validate!
  end

  def disable(code)
    # when disabling a bomb, event :disarm
    @payload.disarm if valid_disarming_code?(code)
  end

  def turn_off(code)
    # when turning off the bomb, event :deactivate
    @payload.deactivate if valid_deactivation_code?(code)
  end

  def disarming_code
    @payload.disarming_code
  end

  def count_disarming_attempts
    add_attempts if @payload.state == 'armed'
  end

  def max_attempts_reached?
    @payload.attempts == @payload.max_attempts
  end

  def trigger_explosion
    @payload.detonate if @payload.state == 'armed'
  end

  def destroy_payload
    @payload.destroy if @payload.state == 'detonated' || @payload.state == 'disarmed'
  end

  private

  def add_attempts
    @payload.attempts += 1
    @payload.save
  end

  def disarming_code=(disarming_code)
    @payload.disarming_code
  end

  def get_payload
    # This gets a current bomb. There can only be one bomb in the record at all
    # times. If no bomb exists, it will return a new instance of bomb that will be
    # saveable.
    bomb = Bombs.all - Bombs.all(:state => :deactivated)
    if bomb.count >= 1
      bomb.first
    else
      Bombs.new
    end
  end

  def valid_boot_code?(code)
    code == boot_code
  end

  def valid_deactivation_code?(code)
    code == deactivation_code
  end

  def valid_disarming_code?(code)
    code == @payload.disarming_code
  end

  def validate!
    if valid?
      true
    else
      raise ValidationError, errors
    end
  end
end
