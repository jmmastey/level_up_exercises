require 'virtus'
require 'active_model'
require './model/bomb.rb'

ValidationError = Class.new RuntimeError

class Interface
  include Virtus.model
  include ActiveModel::Validations

  attribute :activation_code, Integer, :default => 6969 # Because Svajone likes. :D
  attribute :deactivation_code, Integer, :default => 6969 # Because Svajone likes. :D
  attribute :disarming_code, Integer
  attribute :timer, Integer, :default => 30 # 30 seconds or it's free.
  attribute :attempts, Integer, :default => 3 # Three chances, three lives. Let's roll the dice.

  validates :activation_code, :numericality => true
  validates :deactivation_code, :numericality => true
  validates :timer, :numericality => true
  validates :attempts, :numericality => true

  validates :disarming_code, :presence => true,
            :if => Proc.new { |interface| interface.payload.state == 'activated' }

  attr_reader :payload

  def initialize
    # super is necessary to load default love values.
    # seriously, needed to load the default values being assigned
    # by virtus.
    super
    @payload = Bomb.new
  end

  def configure_settings(options = {})
    # Set the activation code, deactivation code, etc
    unless options.nil?
      opts = options.reject { |key, value| value.nil? }
      # I tried using merge here and merge! and it won't update
      # the attributes so instead I used this approach.
      # If you know of a better way, please comment.
      opts.each do |key, value|
        send("#{key}=", value)
      end
      validate!
    end
  end

  def turn_on(code)
    # When activating a bomb, event: activate
    @payload.activate if valid_activation_code?(code)
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

  private

  def valid_activation_code?(code)
    code == activation_code
  end

  def valid_deactivation_code?(code)
    code == deactivation_code
  end

  def valid_disarming_code?(code)
    code == disarming_code
  end

  def validate!
    if valid?
      true
    else
      raise ValidationError, errors
    end
  end
end
