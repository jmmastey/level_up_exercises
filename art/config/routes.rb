Rails.application.routes.draw do
  resources :reviews
  resources :performances
  resources :shows
  resources :performers
  resources :users

  root 'home#trending'
  get 'calendar.:format', to: 'performances#calendar', as: 'calendar'
end
