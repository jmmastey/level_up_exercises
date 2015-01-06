Rails.application.routes.draw do

  root 'good_deeds#index'
  devise_for :users
  resources :legislators, only: [:index, :show]
  resources :bills, only: [:index, :show]
  resources :good_deeds, only: [:index]
  get 'search' => 'search#index'
end
