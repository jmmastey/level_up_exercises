Rails.application.routes.draw do
  resources :characters, only: [:index, :show]
  resources :quests, only: [:show, :edit, :update]
  resources :categories, only: [:index, :show]
  resources :activities, only: [:show]

  devise_for :users

  root 'welcome#index'

  patch 'activities/add_to_goals/:id', to: 'activities#add_to_goals', as: :add_to_goals
end
