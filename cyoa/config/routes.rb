Rails.application.routes.draw do
  root 'index#index'
  get '/poll' => 'index#poll'
end
