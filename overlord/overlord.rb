# run `ruby overlord.rb` to run a webserver for this app
require "haml"
require "sinatra"
require_relative "bomb"

enable :sessions

get '/' do
  session[:bomb] = Bomb.new unless session[:bomb]
  session[:name] = determine_villain_name unless session[:name]
  haml :index, locals: {
    bomb_state: session[:bomb].readable_state,
    name: session[:name],
  }
end

get '/restart' do
  bomb = session[:bomb]
  if bomb.destroyed? || bomb.deactivated? || !bomb
    session[:bomb] = Bomb.new
    session[:name] = determine_villain_name
  end
  redirect('/')
end

post '/configure' do
  boot_up_bomb(params)
  unless session[:bomb].on?
    halt(422, "Your activation and deactivation codes are invalid.")
  end
  halt(200, session[:bomb].readable_state)
end

post '/activate' do
  activate_bomb(params)
  halt(422, "Wrong activation code.") unless session[:bomb].activated?
  halt(200, session[:bomb].readable_state)
end

post '/deactivate' do
  deactivate_bomb(params)
  bomb = session[:bomb]
  unless session[:bomb].deactivated?
    halt(422,
      "Wrong deactivation code. #{bomb.attempts_left} attempts left.")
  end
  halt(200, bomb.readable_state)
end

def boot_up_bomb(params)
  bomb = session[:bomb]
  bomb.boot_up(params[:activation_code], params[:deactivation_code])
end

def activate_bomb(params)
  bomb = session[:bomb]
  bomb.activate(params[:activation_code])
end

def deactivate_bomb(params)
  bomb = session[:bomb]
  bomb.deactivate(params[:deactivation_code])
end

def determine_villain_name
  require 'mechanize'
  mechanize = Mechanize.new
  link = 'http://www.seventhsanctum.com/generate.php?Genname=superheronameorg'
  page = mechanize.get(link)
  page.at('.GeneratorResultPrimeBG').text.strip
end
