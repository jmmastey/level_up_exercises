Rails.application.routes.draw do
  root 'good_deeds#index'

  get 'legislators/favorites', as: 'legislators_favorites', to: 'legislators#favorites'
  get 'legislators/:state', as: 'legislator_search', to: 'legislators#search', state: /[^0-9]+/
  get 'bills/favorites', as: 'bills_favorites', to: 'bills#favorites'
  get 'good_deeds/favorites', as: 'good_deeds_favorites', to: 'good_deeds#favorites'

  devise_for :users
  resources :legislators, only: [:index, :show]
  resources :bills, only: [:index, :show]
  resources :good_deeds, only: [:index]

  get  'search', as: 'search_by_location', to: 'legislators#search_by_location'
  post 'user/favorite/:model/:id', as: 'user_favorite', to: 'user#favorite'
  post 'user/unfavorite/:model/:id', as: 'user_unfavorite', to: 'user#unfavorite'

  scope 'api', defaults: { format: :json }, constraints: { format: :json } do
    get 'legislators', as: 'api_legislators', to: 'legislators#index'
    get 'legislator/:id', as: 'api_legislator', to: 'legislators#show'
    get 'legislators/favorites', as: 'api_legislators_favorites', to: 'legislators#favorites'
    get 'bills', as: 'api_bills', to: 'bills#index'
    get 'bill/:id', as: 'api_bill', to: 'bills#show'
    get 'bills/favorites', as: 'api_bills_favorites', to: 'bills#favorites'
    get 'good_deeds', as: 'api_good_deeds', to: 'good_deeds#index'
    get 'good_deeds/:id', as: 'api_good_deed', to: 'good_deeds#show'
    get 'good_deeds/favorites', as: 'api_good_deeds_favorites', to: 'good_deeds#favorites'
  end
end
