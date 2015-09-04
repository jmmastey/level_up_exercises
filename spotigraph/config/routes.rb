Rails.application.routes.draw do

  devise_for :users
  get '/graph/:name/:depth' => 'graph#generate_graph', :as => :search
  post '/' => 'graph#search_graph'
  root to: 'graph#index'

end
