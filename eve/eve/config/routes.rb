Rails.application.routes.draw do
  resources :items, only: [:index, :show] do
    get 'search', on: :collection, as: :item_search
  end

  resources :orders, only: [:index, :show] do
    get 'search', on: :collection, as: :order_search
  end

  resources :regions, only: [:index, :show] do
    get 'search', on: :collection, as: :region_search
  end

  resources :stations, only: [:index, :show] do
    get 'search', on: :collection, as: :station_search
  end

  resources :watches

  devise_for :users

  get 'home/index'

  root to: "home#index"
end
