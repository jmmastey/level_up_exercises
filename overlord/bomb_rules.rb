require_relative 'state_machine'
require 'pry'

module BombRules
  
  def self.is_or_can_activate? bomb
    (bomb.name.eql?(StateMachine.dormant) && validate_code(bomb.state[:activation_code])) || bomb.name.eql?(StateMachine.active)
  end

  def self.is_or_can_explode? bomb
    bomb.name.eql?(StateMachine.active) && (bomb.state[:retries] <= 0 || (bomb.state[:timer].to_i - (Time.now - bomb.state[:armed_at]) <= 0))
  end

  def self.is_or_can_deactivate? bomb
    bomb.name.eql?(StateMachine.blown) || (bomb.name.eql?(StateMachine.active) && validate_code(bomb.state[:deactivation_code])) || bomb.name.eql?(StateMachine.dormant)
  end
  
  def self.validate_code(code)
    !(code =~ /\d{4}/).nil?
  end

end
