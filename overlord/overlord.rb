#!/usr/bin/ruby -w
# run `ruby overlord.rb` to run a webserver for this app

require "sinatra"
require_relative "lib/supervillian/bomb.rb"

use Rack::Session::Pool

CONTROL_PANEL_URL = "/control_panel"
EXPLODED_URL = "/kaboom"
MASKED_ACTIVATION_CODE = '****'

set :bind, '0.0.0.0'

def bomb
  session[:bomb]
end

USER_MESSAGES =
{
  exploded: "All your base are belong to us.",
  ready_to_disarm: "Enter disarming code, push DISARMED and commit to confirm.  You have no chance to survive. Make your time. HA HA HA.",
  ready_to_arm: "Somebody set up us the bomb! Enter arming code, push ARMED and commit to confirm.",
  ready_to_lock: "Enter arming and disarming codes and commit to lock in. Take off every zig!",
}

def setup_session
  session[:bomb] ||= Supervillian::Bomb.new
  @arming_code = bomb.locked ? MASKED_ACTIVATION_CODE : bomb.arming_code
  @disarming_code = bomb.locked ? MASKED_ACTIVATION_CODE : bomb.disarming_code
end

before do
  setup_session
  apply_timer_value if request.post?
  determine_system_message
end

get '/' do
  redirect CONTROL_PANEL_URL
end

post '/cancel' do
  attempt_bomb_command_when { apply_timer_value }
  redirect CONTROL_PANEL_URL
end

get EXPLODED_URL do
  erb :exploded, layout: false
end

get CONTROL_PANEL_URL do
  check_exploded
  erb :control_panel, layout: :layout
end

post '/lock' do
  attempt_bomb_command_when(!bomb.locked) do
    bomb.arming_code = params[:arming_code]
    bomb.disarming_code = params[:disarming_code]
    bomb.lock
  end
end

post '/arm' do
  attempt_bomb_command_when(bomb.locked) do
    apply_timer_value
    bomb.arm(params[:arming_code])
  end
end

post '/disarm' do
  attempt_bomb_command_when(bomb.armed) { bomb.disarm(params[:disarming_code]) }
end

not_found do
  redirect CONTROL_PANEL_URL
end

def perform_bomb_command
  yield
rescue Supervillian::ExplodedError
  redirect "/exploded"
rescue Supervillian::BombError => ex
  self.system_message = ex.message
end

def attempt_bomb_command_when(guard_condition = true, &block)
  check_exploded
  raise "Guard condition failed" unless guard_condition
  perform_bomb_command(&block)
rescue
  self.system_message = "Ooops.. something bad happened. Don't do that again"
ensure
  redirect CONTROL_PANEL_URL
end

def can_be_armed?
  bomb.locked && !bomb.armed
end

def can_be_disarmed?
  bomb.armed
end

def apply_timer_value
  new_value = params[:timer_value].to_i
  bomb.delay = params[:timer_value].to_i if bomb.locked && new_value != 0
end

def check_exploded
  redirect EXPLODED_URL if bomb.exploded?
end

def system_message=(message)
  session[:system_message] = message
end

def user_message(message_key)
  USER_MESSAGES[message_key]
end

def determine_system_message
  @system_message = session[:system_message] || system_state_message
  reset_system_message
end

def reset_system_message
  session.delete(:system_message)
end

def system_state_message
  return user_message(:exploded) if bomb.exploded?
  return user_message(:ready_to_disarm) if bomb.armed
  return user_message(:ready_to_arm) if bomb.locked
  user_message(:ready_to_lock)
end
