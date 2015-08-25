Rails.application.routes.draw do

  post '/' => 'graph#generate_graph'
  root 'graph#index'

end
