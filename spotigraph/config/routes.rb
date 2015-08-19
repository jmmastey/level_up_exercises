Rails.application.routes.draw do

  post '/' => 'artists#generate_graph'
  root 'artists#index'

end
