require 'pry'

require_relative 'state_machine'
require_relative 'state'

class ApplicationController
  include StateMachine

  ACTION = {"/" => "/", "/activated" => "/activated", "/boom" => "/boom", "/deactivate" => "/", "/activate" => "/activated"}

  def service(session, request)
    session[:bomb] ||= State.new(StateMachine.dormant)

    apply_parameters session[:bomb], request.params
    to = STATES.key(ACTION[request.path_info]).to_s
    message, transitioned, redirected = transition(session[:bomb], to)
    override_defaults session[:bomb], request.params

    [STATES[session[:bomb].name.intern], transitioned || redirected, message]
  end

  def apply_parameters bomb, params
    bomb.state.merge!(params.inject({}) { |memo,(k,v)| memo[k.to_sym] = v unless v.empty?; memo })
  end

  def override_defaults bomb, params
    bomb.state[:timer] = params["timer"] unless params["timer"].nil? or params["timer"].empty?
  end

end
