Rails.application.routes.draw do
  resources :characters
  resources :quests
  resources :categories

  devise_for :users

  root 'welcome#index'
end
