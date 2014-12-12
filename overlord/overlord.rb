require 'Sinatra'
class Overlord < Sinatra::Base
  set :public_folder => "public", :static => true

  get "/" do
    session[:status] ||= "Inactive"
    erb :index
  end

  post "/init" do
    if session[:status] == "Active"
      redirect :countdown
    else
      erb :index
    end
  end
end
