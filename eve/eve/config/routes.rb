Rails.application.routes.draw do
  resources :items, only: [:index, :show] do
    get 'search', on: :collection, as: :search
  end

  resources :orders, only: [:index, :show] do
    get 'search', on: :collection, as: :search
  end

  resources :regions, only: [:index, :show] do
    get 'search', on: :collection, as: :search
  end

  resources :stations, only: [:index, :show] do
    get 'search', on: :collection, as: :search
  end

  authenticate :user do
    resources :watches
  end

  devise_for :users

  get 'home/index'

  root to: "home#index"
end
