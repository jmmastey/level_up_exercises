# # run `ruby overlord.rb` to run a webserver for this app
#
# require 'sinatra'
#
#
# class Overlord < Sinatra::Application
#   enable :sessions
#
#
#   get '/' do
#     erb :index, :layout => :base
#   end
#   # we can shove stuff into the session cookie YAY!
#   def start_time
#     session[:start_time] ||= (Time.now).to_s
#   end
#
#
#
#
#   run! if app_file == $0
#
# end
#
#
#
#
