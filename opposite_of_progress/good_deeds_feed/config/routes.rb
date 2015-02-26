Rails.application.routes.draw do
  get 'favorites/create'

  get 'favorites/destroy'

  get 'good_deeds/index'

  get 'good_deeds/show'

  get 'legislators/index'

  get 'legislators/show'

  get 'bills/index'

  get 'bills/show'

  get 'sessions/new'

  root 'good_deeds#index'

  get 'users/new'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'legislators_by_party' => 'legislators#by_party'
  get 'good_deeds_by_party' => 'good_deeds#by_party'
  get 'good_deeds_json_feed' => 'good_deeds#json_feed'
  resources :legislators
  resources :good_deeds
  resources :users
  resources :favorites, only: [:create, :destroy]
end
