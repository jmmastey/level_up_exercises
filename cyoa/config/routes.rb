Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :users, only: [:show, :update]
  resources :user_tags, only: [:create, :destroy], param: :tag_id
  resources :legislators, only: [:show, :index]

  get '/good_deed' => 'bills#random_good_deed'
  resources :bills, only: [:show, :index], param: :bill_id

  resources :bookmarks, only: [:create, :index]
  delete '/bookmarks' => 'bookmarks#destroy'
end
