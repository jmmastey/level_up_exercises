Rails.application.routes.draw do
  devise_for :users

  # get "auth/delivery/authorize",
  #   to: "delivery_auth#authorize",
  #   as: :delivery_auth_authorize

  # get "auth/delivery/callback",
  #   to: "delivery_auth#callback",
  #   as: :delivery_auth_callback

  resources :merchants, only: [:index, :show]

  # resource :session, only: [:new, :create, :destroy] do
  #   get "error", to: "sessions#error"
  # end

  root "home#index"
end
