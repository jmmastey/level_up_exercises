require 'Sinatra'
class Overlord < Sinatra::Base
  set :public_folder => "public", :static => true
  configure(:development) { set :session_secret, "something" }
  enable :sessions

  get "/" do
    if session[:status] == "Active"
      erb :countdown
    else
      if session[:status] == "Exploded"
        erb :explode
      else
        session[:status] = "Inactive"
        erb :index
      end
    end
  end

  post "/init" do
    session[:status] = "Active"
    erb :countdown
  end

  post "/defuse" do
    session[:status] = "Inactive"
    redirect '/'
  end

  post "/newsession" do
    session.clear
    redirect '/'
  end

  get "/explode" do
    session[:status] = "Exploded"
    erb :explode
  end
end
