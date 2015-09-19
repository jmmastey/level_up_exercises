Rails.application.routes.draw do
  resources :characters, only: [:index, :show]
  resources :quests, only: [:show, :edit, :update]
  resources :categories, only: [:index, :show]

  devise_for :users

  root 'welcome#index'
end
