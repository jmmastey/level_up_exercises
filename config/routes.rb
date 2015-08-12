Rails.application.routes.draw do

  post '/' => 'artists#generate_graph'

  get '/about' => 'static_pages#about'

  root 'artists#generate_graph'

end
