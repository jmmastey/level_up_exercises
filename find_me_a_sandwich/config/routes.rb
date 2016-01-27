Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :merchants, only: [:index, :show]

  resources :users, only: [:index, :show]
  resource :profile, only: [:show, :edit, :update], controller: "users"

  resource :favorites
  get "favorites/new/:id", controller: "favorites", action: "new"
  get "favorites/destroy/:id", controller: "favorites", action: "destroy"
  get "favorites/:id", controller: "favorites", action: "show"
end
