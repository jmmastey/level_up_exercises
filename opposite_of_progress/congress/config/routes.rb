Rails.application.routes.draw do
  devise_for :users
  root "deeds#index"
  get 'home' => "deeds#index"

  get 'preferences' => "users#preferences"
  post 'preferences' => "users#update"

  resources :bills
  resources :legislators
  resources :deeds
end
