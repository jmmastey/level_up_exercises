Rails.application.routes.draw do
  resources :reviews
  resources :performances
  resources :shows
  resources :performers
  resources :users

  root 'shows#index'
end
