# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'bomb'
require_relative 'bomb_form_text'
require_relative 'bomb_session'

enable :sessions

get '/' do
  start_time
  @bomb = get_bomb_instance
  erb :bomb_form
end

post '/' do
  @bomb = get_bomb_instance
  @bomb.process_code(params['code'])
  bomb_to_session(@bomb)
  redirect '/'
end

# we can shove stuff into the session cookie YAY!
def start_time
  session[:start_time] ||= (Time.now).to_s
end

#class BombSession
def started?
  Bomb.instance_methods.any? { |name| session.has_key?(name) }
end

def bomb_to_session(bomb)
  bomb.instance_variables.each { |name| update_session_variable(name) }
end

def update_session_variable(name)
  session_variable = instance_var_to_symbol(name)
  session[session_variable] = instance_variable_get(name)
end

def session_to_bomb
  Bomb.new(session)
end

def instance_var_to_symbol(var)
  var.to_s.sub("@", ":")
end

def get_bomb_instance
  if started?
    session_to_bomb
  else
    @bomb = Bomb.new
    bomb_to_session(@bomb)
    @bomb
  end
end
#end