Rails.application.routes.draw do

  devise_for :users
  post '/' => 'graph#generate_graph'
  root 'graph#index'

end
