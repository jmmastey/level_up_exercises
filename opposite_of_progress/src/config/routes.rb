Rails.application.routes.draw do

  root 'good_deeds#index'
  get 'legislators/:state_or_chamber', as: 'legislator_search',
    to: 'legislators#search', state_or_chamber: /[^0-9]+/
  devise_for :users
  resources :legislators, only: [:index, :show]
  resources :bills, only: [:index, :show]
  resources :good_deeds, only: [:index]
  get 'search' => 'search#index'
end
