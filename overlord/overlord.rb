require 'Sinatra'
class Overlord < Sinatra::Base
  set :public_folder => "public", :static => true
  configure(:development) { set :session_secret, "something" }
  enable :sessions

  get "/" do
    session[:status] ||= "Inactive"
    session[:activate] ||= "1234"
    session[:deactivate] ||= "4321"
    session[:failed] ||= 0
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
    if authenticate
      session[:status] = "Active"
      session[:failed] = 0
      erb :countdown
    else
      session[:failed] += 1
      if session[:failed] == 3
        redirect "/explode"
      end
      redirect "/"
    end
  end

  post "/defuse" do
    if params[:defuse] == session[:deactivate]
      session[:status] = "Inactive"
    end
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

  post "/change" do
    session[:activate] = params[:new_acode]
    session[:deactivate] = params[:new_dcode]
    redirect '/'
  end

  def authenticate
    session[:activate] == params[:code]
  end
end
