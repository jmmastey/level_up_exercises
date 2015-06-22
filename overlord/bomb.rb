require_relative 'constants'

class String
  def numeric?
    true if Float(self) rescue false
  end
end

class Bomb
  attr_reader :error_count, :status

  DEFAULT_CODES = {
    activation_code: '1234',
    deactivation_code: '0000',
  }

  def initialize(params = {})
    collect_errors do
      params = symbolize_params(params)
      validate_codes([:activation_code, :deactivation_code], params)
      create_bomb(params) if @errors.length == 0
    end
  end

  def activate(code = '', key = :activation_code)
    collect_errors do
      validate_bomb_can_activate
      validate_codes([key], activation_code: code) if @errors.length == 0
      valid_activation_code?(code) if @errors.length == 0
      @status = :active if @errors.length == 0
    end
  end

  def deactivate(code = '', key = :deactivation_code)
    collect_errors do
      validate_bomb_can_deactivate
      validate_codes([key], deactivation_code: code)
      valid_deactivation_code?(code) if @errors.length == 0
      @status = :inactive if @errors.length == 0
      log_bad_deactivation_attempt if @errors.length > 0
    end
  end

  private

  def log_bad_deactivation_attempt
    @error_count += 1
    explode if @error_count >= 3
  end

  def explode
    @status = :exploded
  end

  def create_bomb(params)
    @activation_code = params[:activation_code]
    @deactivation_code = params[:deactivation_code]
    @error_count = 0
    @status = :inactive
  end

  def collect_errors
    @errors = []
    yield
    errors = @errors
    remove_instance_variable(:@errors)
    errors
  end

  def symbolize_params(params = {})
    return DEFAULT_CODES if params.empty?
    new_params = {}
    params.each do |key, value|
      new_params[key.to_sym] = value
    end
    new_params
  end

  def validate_bomb_can_activate
    @errors << ERRORS[:already_active] if @status == :active
    validate_bomb_is_exploded
  end

  def validate_bomb_can_deactivate
    @errors << ERRORS[:already_inactive] if @status == :inactive
    validate_bomb_is_exploded
  end

  def validate_bomb_is_exploded
    @errors << ERRORS[:exploded] if @status == :exploded
  end

  def validate_codes(keys = [], request = {})
    keys.each do |key|
      if !request.key?(key) || request[key] == ''
        @errors << ERRORS[:required].call(key)
      elsif !request[key].numeric?
        @errors << ERRORS[:numeric].call(key)
      end
    end
  end

  def valid_activation_code?(code = '')
    return if code.to_s == @activation_code
    @errors << ERRORS[:incorrect_code].call(:activation_code)
  end

  def valid_deactivation_code?(code = '')
    return if code.to_s == @deactivation_code
    @errors << ERRORS[:incorrect_code].call(:deactivation_code)
  end
end
