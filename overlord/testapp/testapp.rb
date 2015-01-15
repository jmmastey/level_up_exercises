require 'twitter'
require 'sinatra'

set :server, 'webrick'

enable :sessions

get '/' do erb :index

end

