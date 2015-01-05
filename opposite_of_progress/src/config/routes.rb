Rails.application.routes.draw do
  get 'search/index'

  root 'good_deeds#index'
  resources :legislators
  resources :bills
  resources :good_deeds
  get 'search' => 'search#index'
end
