Rails.application.routes.draw do
  root 'good_deeds#index'

  get 'legislators/favorites', as: 'legislators_favorites', to: 'legislators#favorites'
  get 'legislators/:state', as: 'legislator_search', to: 'legislators#search', state_or_chamber: /[^0-9]+/
  get 'bills/favorites', as: 'bills_favorites', to: 'bills#favorites'
  get 'good_deeds/favorites', as: 'good_deeds_favorites', to: 'good_deeds#favorites'

  devise_for :users
  resources :legislators, only: [:index, :show]
  resources :bills, only: [:index, :show]
  resources :good_deeds, only: [:index]

  get 'search', as: 'search_by_location', to: 'legislators#search_by_location'
  post 'user/favorite/:model/:id', as: 'user_favorite', to: 'user#favorite'
  post 'user/unfavorite/:model/:id', as: 'user_unfavorite', to: 'user#unfavorite'
end
