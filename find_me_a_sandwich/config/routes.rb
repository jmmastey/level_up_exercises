Rails.application.routes.draw do
  devise_for :users

  resources :merchants, only: [:index, :show]

  resources :users, only: [:index, :show]
  resource :profile, only: [:show, :edit, :update], controller: "users"

  root "home#index"
end
